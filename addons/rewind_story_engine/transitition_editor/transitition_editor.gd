@tool
class_name RSETransititionEditor
extends Control


@export var item_list: ItemList

@export var name_line_edit: LineEdit

@export var open_scene_file_dialog: FileDialog
@export var path_label: Label

@export var preview_viewport: SubViewport


var story: RSEStory
var transitition: RSETransitition : set = _set_transitition_effect

var preview_transitition: RSEBaseTransititionController


func _set_transitition_effect(trn: RSETransitition) -> void:
	transitition = trn
	if trn == null:
		return
	name_line_edit.text = trn.name
	path_label.text = trn.path_to_scene
	_set_preview()


func _set_preview() -> void:
	if is_instance_valid(preview_transitition):
		preview_transitition.queue_free()
	
	if transitition.path_to_scene == "":
		return
	
	if not FileAccess.file_exists(transitition.path_to_scene):
		return
	
	preview_transitition = load(transitition.path_to_scene).instantiate()
	preview_viewport.add_child(preview_transitition)

	#preview_character.character = character


func load_story(s: RSEStory) -> void:
	story = s
	update_item_list()
	if story.transititions.size() > 0:
		transitition = story.transititions.values()[0]
		item_list.select(0)
	else:
		transitition = null


func update_item_list() -> void:
	item_list.clear()
	for transitition: RSETransitition in story.transititions.values():
		item_list.add_item(transitition.get_id_with_name())


func _on_file_dialog_file_selected(path):
	if transitition == null:
		return
	
	path_label.text = path
	if transitition.path_to_scene != path:
		transitition.path_to_scene = path
		_set_preview()


func _on_item_list_item_selected(index):
	transitition = story.transititions.values()[index]


func _on_line_edit_text_changed(new_text):
	if transitition == null:
		return
	
	transitition.name = new_text


func _on_open_file_pressed():
	open_scene_file_dialog.show()


func _on_erase_pressed():
	if transitition == null:
		return
	
	path_label.text = ""
	transitition.path_to_scene = ""
	_set_preview()


func _on_play_pressed():
	if preview_transitition == null:
		return
	
	preview_transitition.play()
