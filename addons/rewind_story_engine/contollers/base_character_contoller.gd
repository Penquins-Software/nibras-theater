@tool
class_name RSEBaseCharacterController
extends RSEBaseController

@export_category("Editor")
@export var play_animations_in_editor: bool = false

@export_category("Emotion")
@export var emotion_ids_to_anim_names: Dictionary

@export_category("Head")
#@export var head: Node2D
@export var eyes: AnimatedSprite2D
@export var mouth: AnimatedSprite2D

#@export_category("Body")
#@export var body: Node2D

@export_category("Other")
@export var eyes_frame_open: int
@export var eyes_frame_close: int
@export var default_emotion: String = "default"
@export var bleep_player: BleepPlayer


var character: RSECharacter : set = _set_character
var _emotion_id: int
var _outfit_id: int
var emotion: String
var anim_name: String

var talking: bool = false
var talking_time: float = 0.0

var blinking: bool = true
var blinking_time: float = 1.0

## Используется для эффекта тени.
var twin: RSEBaseCharacterController

var flip_h: bool = false : set = _set_flip_h
var order: int = 0 : set = _set_order


func _set_character(ch: RSECharacter) -> void:
	character = ch
	
	if bleep_player != null:
		var bleep = load(ch.path_to_bleep_sound)
		if bleep is AudioStream:
			bleep_player.stream = bleep


func _set_flip_h(value: bool) -> void:
	flip_h = value
	_set_flip_h_for_all_sprites()
	if not twin == null:
		twin.flip_h = flip_h
		if not flip_h:
			twin.position = Vector2(-20, 20)
		else:
			twin.position = Vector2(20, 20)


func _set_flip_h_for_all_sprites() -> void:
	_set_flip_for_part(self)


func _set_flip_for_part(node: Node) -> void:
	if node is AnimatedSprite2D or node is Sprite2D:
		node.flip_h = flip_h
	
	for child in node.get_children():
		_set_flip_for_part(child)


func _set_order(order_index: int) -> void:
	order = order_index
	z_index = order_index
	if not twin == null:
		twin.order = order_index - 1
	#_set_order_for_all_sprites()


func _set_order_for_all_sprites() -> void:
	for child in get_children():
		_set_order_for_node(child)


func _set_order_for_node(node: Node) -> void:
	if not twin == null and node == twin:
		twin.order = order - 1
		return
	
	if node is CanvasItem:
		node.z_index = order
	
	for child in node.get_children():
		_set_order_for_node(child)


func reset() -> void:
	position = Vector2.ZERO
	rotation_degrees = 0
	scale = Vector2.ONE
	flip_h = false
	order = 0
	reseted.emit()


func _ready():
	if emotion_ids_to_anim_names.size() < 1:
		return
	
	anim_name = emotion_ids_to_anim_names.values()[0]
	
	blinking_time = randf_range(1.5, 3.0)


func _process(delta):
	_check_blinking_time(delta)
	_check_talking_time(delta)


func set_emotion(emotion_id: int) -> bool:
	if character == null:
		return false
	
	if not character.emotions.keys().has(str(emotion_id)):
		push_warning("Персонаж '%s' не имеет эмоции с ID '%s'." % [character.name, emotion_id])
		return false
	
	#if emotion == character.emotions[str(emotion_id)]:
		#return false
	
	_emotion_id = emotion_id
	
	if emotion_ids_to_anim_names.size() > 0:
		if emotion_ids_to_anim_names.keys().has(emotion_id):
			emotion = character.emotions[str(emotion_id)]
			anim_name = emotion_ids_to_anim_names[emotion_id]
		else:
			anim_name = emotion_ids_to_anim_names.values()[0]
	
	_set_emotion_for_all_parts()
	if not twin == null:
		twin.set_emotion(emotion_id)
	return true


func _set_emotion_for_all_parts() -> void:
	_set_emotion_for_part(self)


func _set_emotion_for_part(node: Node) -> void:
	if node is AnimatedSprite2D:
		if node.sprite_frames.has_animation(anim_name):
			node.animation = anim_name
		else:
			node.animation = default_emotion
	
	for child in node.get_children():
		_set_emotion_for_part(child)


func set_outfit(outfit_id: int) -> void:
	_outfit_id = outfit_id
	
	_set_special(outfit_id == 1)
	
	if outfit_id == 2:
		make_twin()
	else:
		if is_instance_valid(twin):
			twin.queue_free()


func _set_special(status: bool) -> void:
	pass


func talk(time: float = 0.0) -> void:
	talking_time = time
	talking = true
	start_talk()


## Персонаж будет открывать рот в соответсвии с озвучкой.
func talk_with_audio(audio: AudioStream) -> void:
	pass


func start_talk() -> void:
	if bleep_player != null and not Engine.is_editor_hint():
		bleep_player._play()
	
	if anim_name == null:
		return
	
	if mouth != null:
		if mouth.sprite_frames.has_animation(anim_name):
			mouth.play(anim_name)
		else:
			mouth.play(default_emotion)


func stop_talk() -> void:
	if bleep_player != null:
		bleep_player._stop()
	
	if mouth != null:
		mouth.stop()
		talking = false


func _check_talking_time(delta: float) -> void:
	if not talking:
		return
	
	talking_time -= delta
	if talking_time < 0:
		stop_talk()


func blink() -> void:
	if anim_name == null:
		return
	
	if Engine.is_editor_hint() and not play_animations_in_editor:
		return
	
	if eyes != null:
		if eyes.sprite_frames.has_animation(anim_name):
			eyes.play(anim_name)
		else:
			eyes.play(default_emotion)


func _check_blinking_time(delta: float) -> void:
	if not blinking:
		return
	
	blinking_time -= delta
	if blinking_time < 0:
		blinking_time = randf_range(2.2, 3.8)
		blink()


func set_blinking(status: bool) -> void:
	blinking = status


func open_eyes() -> void:
	set_blinking(false)
	
	if eyes != null:
		eyes.frame = eyes_frame_open


func close_eyes() -> void:
	set_blinking(false)

	if eyes != null:
		eyes.frame = eyes_frame_close


func make_twin() -> void:
	if not twin == null:
		return
	
	twin = (load(character.path_to_scene) as PackedScene).instantiate() as RSEBaseCharacterController
	twin.modulate = Color.BLACK
	add_child(twin)
	twin.z_as_relative = false
	twin.z_index -= 1
	twin.flip_h = flip_h
	twin.set_emotion(_emotion_id)
	if not flip_h:
		twin.position = Vector2(-20, 20)
	else:
		twin.position = Vector2(20, 20)
