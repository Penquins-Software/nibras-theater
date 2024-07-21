@tool
class_name RSEBaseCharacterController
extends RSEBaseController


@export_category("Emotion")
@export var emotion_ids_to_anim_names: Dictionary

@export_category("Head")
@export var head: Node2D
@export var eyes: AnimatedSprite2D
@export var mouth: AnimatedSprite2D

@export_category("Body")
@export var body: Node2D
@export var tors: AnimatedSprite2D

@export_category("Other")
@export var eyes_frame_open: int
@export var eyes_frame_close: int
@export var default_emotion: String = "default"


var character: RSECharacter
var emotion: String
var anim_name: StringName

var talking: bool = false
var talking_time: float = 0.0

var blinking: bool = true
var blinking_time: float = 1.0

var flip_h: bool = false : set = _set_flip_h
var order: int = 0 : set = _set_order


func _set_flip_h(value: bool) -> void:
	flip_h = value
	_set_flip_h_for_all_sprites()


func _set_flip_h_for_all_sprites() -> void:
	if tors:
		tors.flip_h = flip_h
	if eyes:
		eyes.flip_h = flip_h
	if mouth:
		mouth.flip_h = flip_h


func _set_order(order_index: int) -> void:
	order = order_index
	_set_order_for_all_sprites()


func _set_order_for_all_sprites() -> void:
	if tors:
		tors.z_index = order
	if eyes:
		eyes.z_index = order
	if mouth:
		mouth.z_index = order


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
	pass


func _process(delta):
	_check_blinking_time(delta)
	_check_talking_time(delta)


func set_emotion(emotion_id: int) -> bool:
	if character == null:
		return false
	
	if not character.emotions.keys().has(str(emotion_id)):
		push_warning("Персонаж '%s' не имеет эмоции с ID '%s'." % [character.name, emotion_id])
		return false
	
	if emotion == character.emotions[str(emotion_id)]:
		return false
	
	if emotion_ids_to_anim_names.size() > 0:
		if emotion_ids_to_anim_names.keys().has(emotion_id):
			emotion = character.emotions[str(emotion_id)]
			anim_name = emotion_ids_to_anim_names[emotion_id]
		else:
			anim_name = emotion_ids_to_anim_names.values()[0]
	
	_set_emotion_for_all_parts()
	return true


func _set_emotion_for_all_parts() -> void:
	if eyes != null:
		eyes.animation = anim_name
	if mouth != null:
		mouth.animation = anim_name


func set_outfit(outfit_id: int) -> void:
	pass


func talk(time: float = 0.0) -> void:
	talking_time = time
	talking = true
	start_talk()


## Персонаж будет открывать рот в соответсвии с озвучкой.
func talk_with_audio(audio: AudioStream) -> void:
	pass


func start_talk() -> void:
	if anim_name == null:
		return
	
	if mouth != null:
		mouth.play(anim_name)


func stop_talk() -> void:
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
	
	if eyes != null:
		eyes.play(anim_name)


func _check_blinking_time(delta: float) -> void:
	if not blinking:
		return
	
	blinking_time -= delta
	if blinking_time < 0:
		blinking_time = randf_range(0.8, 2.2)
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
