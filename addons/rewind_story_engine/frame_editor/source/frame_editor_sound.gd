@tool
class_name FrameEditorSound
extends FrameEditor


@export var sound: MenuButton
@export var status: MenuButton

var current_status: bool = false


func _ready():
	_base_setting()
	sound.get_popup().index_pressed.connect(_set_effect)
	status.get_popup().index_pressed.connect(_set_status)


func _set_effect(index: int) -> void:
	_set_menu_button_index(index, sound, true)
	status.visible = true


func _set_status(index: int) -> void:
	_set_menu_button_index(index, status, true)
	current_status = bool(index)


func get_frame() -> RSEFrameSoundEffect:
	var frame = RSEFrameSoundEffect.new()
	if selected_menu_indicies.has(sound):
		frame.sound_id = sound.get_popup().get_item_id(selected_menu_indicies[sound])
	frame.status = current_status
	return frame


func setting(story: RSEStory, frame: RSEFrameSoundEffect) -> void:
	self.story = story
	for snd: RSESoundEffect in story.sound_effects.values():
		if snd.active:
			sound.get_popup().add_item(snd.name, snd.id)
	if frame != null:
		if story.sound_effects.has(frame.sound_id):
			_set_effect(sound.get_popup().get_item_index(frame.sound_id))
			_set_status(int(frame.status))
