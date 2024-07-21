@tool
class_name FrameEditorTransitition
extends FrameEditor


@export var transitiion: MenuButton


func _ready():
	_base_setting()
	transitiion.get_popup().index_pressed.connect(_set_menu_button_index.bind(transitiion, false))


func get_frame() -> RSEFrameTransitition:
	var frame = RSEFrameTransitition.new()
	if selected_menu_indicies.has(transitiion):
		frame.transitition_id = transitiion.get_popup().get_item_id(selected_menu_indicies[transitiion])
	return frame


func setting(story: RSEStory, frame: RSEFrameTransitition) -> void:
	self.story = story
	for tr: RSETransitition in story.transititions.values():
		if tr.active:
			transitiion.get_popup().add_item(tr.name, tr.id)
	if frame != null:
		if story.transititions.has(frame.transitition_id):
			_set_menu_button_index(transitiion.get_popup().get_item_index(frame.transitition_id), transitiion, false)
