@tool
class_name RSELocationEditor
extends Control


@export var location_item_list: ItemList

@export var location_name_line_edit: LineEdit

@export var location_open_scene_file_dialog: FileDialog
@export var location_path_label: Label

@export var location_preview_viewport: SubViewport
@export var location_preview_camera: Camera2DDragging


var story: RSEStory
var location: RSELocation : set = _set_location

var selected_index: int
var preview_location: RSEBaseLocationController


func _set_location(loc: RSELocation) -> void:
	location = loc
	if loc == null:
		return
	location_name_line_edit.text = loc.name
	location_path_label.text = loc.path_to_scene
	_set_preview()


func _set_preview() -> void:
	if is_instance_valid(preview_location):
		preview_location.queue_free()
	
	if location.path_to_scene == "":
		return
	
	if not FileAccess.file_exists(location.path_to_scene):
		return
	
	preview_location = load(location.path_to_scene).instantiate()
	location_preview_viewport.add_child(preview_location)

	#preview_character.character = character


func load_story(s: RSEStory) -> void:
	story = s
	update_item_list()
	if story.locations.size() > 0:
		location = story.locations.values()[0]
		location_item_list.select(0)
	else:
		location = null


func update_item_list() -> void:
	location_item_list.clear()
	for location: RSELocation in story.locations.values():
		location_item_list.add_item(location.get_id_with_name())


func _on_name_edit_text_changed(new_text):
	if location == null:
		return
	
	location.name = new_text


func _on_open_file_pressed():
	location_open_scene_file_dialog.show()


func _on_file_dialog_file_selected(path):
	if location == null:
		return
	
	location_path_label.text = path
	if location.path_to_scene != path:
		location.path_to_scene = path
		_set_preview()


func _on_erase_pressed():
	if location == null:
		return
	
	location_path_label.text = ""
	location.path_to_scene = ""
	_set_preview()


func _on_sub_viewport_container_gui_input(event):
	location_preview_camera._input(event)


func _on_reset_camera_pressed():
	location_preview_camera.reset()


func _on_item_list_item_selected(index):
	location = story.locations.values()[index]
	selected_index = index
