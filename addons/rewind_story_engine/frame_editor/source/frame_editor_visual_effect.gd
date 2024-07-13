@tool
class_name FrameEditorVisualEffect
extends FrameEditor


@export var effect: MenuButton
@export var status: MenuButton

var current_status: bool = false


func _ready():
	_base_setting()
	effect.get_popup().index_pressed.connect(_set_effect)
	status.get_popup().index_pressed.connect(_set_status)


func _set_effect(index: int) -> void:
	_set_menu_button_index(index, effect, true)
	status.visible = true


func _set_status(index: int) -> void:
	_set_menu_button_index(index, status, true)
	current_status = bool(index)


func get_frame() -> RSEFrameVisualEffect:
	var frame = RSEFrameVisualEffect.new()
	if selected_menu_indicies.has(effect):
		frame.effect_id = effect.get_popup().get_item_id(selected_menu_indicies[effect])
	frame.status = current_status
	return frame


func setting(story: RSEStory, frame: RSEFrameVisualEffect) -> void:
	self.story = story
	for vsl: RSEVisualEffect in story.visual_effects.values():
		if vsl.active:
			effect.get_popup().add_item(vsl.name, vsl.id)
	if frame != null:
		if story.visual_effects.has(frame.effect_id):
			_set_effect(effect.get_popup().get_item_index(frame.effect_id))
		_set_status(int(frame.status))
