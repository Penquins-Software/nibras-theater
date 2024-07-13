@tool
class_name FrameEditorLocation
extends FrameEditor


@export var location: MenuButton
@export var transitiion: MenuButton


func _ready():
	_base_setting()
	location.get_popup().index_pressed.connect(_set_location)
	transitiion.get_popup().index_pressed.connect(_set_menu_button_index.bind(transitiion, false))


func _set_location(index: int) -> void:
	_set_menu_button_index(index, location, false)
	transitiion.visible = true


func get_frame() -> RSEFrameLocation:
	var frame = RSEFrameLocation.new()
	if selected_menu_indicies.has(location):
		frame.location_id = location.get_popup().get_item_id(selected_menu_indicies[location])
	if selected_menu_indicies.has(transitiion):
		frame.transitition_id = transitiion.get_popup().get_item_id(selected_menu_indicies[transitiion])
	return frame


func setting(story: RSEStory, frame: RSEFrameLocation) -> void:
	self.story = story
	for loc: RSELocation in story.locations.values():
		if loc.active:
			location.get_popup().add_item(loc.name, loc.id)
	for tr: RSETransitition in story.transititions.values():
		if tr.active:
			transitiion.get_popup().add_item(tr.name, tr.id)
	if frame != null:
		if story.locations.has(frame.location_id):
			_set_location(location.get_popup().get_item_index(frame.location_id))
		if story.transititions.has(frame.transitition_id):
			_set_menu_button_index(transitiion.get_popup().get_item_index(frame.transitition_id), transitiion, false)
