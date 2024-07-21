@tool
class_name FrameEditorLocation
extends FrameEditor


@export var location: MenuButton


func _ready():
	_base_setting()
	location.get_popup().index_pressed.connect(_set_location)


func _set_location(index: int) -> void:
	_set_menu_button_index(index, location, false)


func get_frame() -> RSEFrameLocation:
	var frame = RSEFrameLocation.new()
	if selected_menu_indicies.has(location):
		frame.location_id = location.get_popup().get_item_id(selected_menu_indicies[location])
	return frame


func setting(story: RSEStory, frame: RSEFrameLocation) -> void:
	self.story = story
	for loc: RSELocation in story.locations.values():
		if loc.active:
			location.get_popup().add_item(loc.name, loc.id)
	if frame != null:
		if story.locations.has(frame.location_id):
			_set_location(location.get_popup().get_item_index(frame.location_id))
