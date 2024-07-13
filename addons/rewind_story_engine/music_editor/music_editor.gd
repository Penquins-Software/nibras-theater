@tool
class_name RSEMusicEditor
extends Control


@export var item_list: ItemList

@export var name_line_edit: LineEdit

@export var open_scene_file_dialog: FileDialog
@export var path_label: Label


var story: RSEStory
var music: RSEMusic : set = _set_music

var selected_index: int


func _set_music(m: RSEMusic) -> void:
	music = m
	if m == null:
		return
	name_line_edit.text = m.name
	path_label.text = m.path_to_file


func load_story(s: RSEStory) -> void:
	story = s
	update_item_list()
	if story.music_list.size() > 0:
		music = story.music_list.values()[0]
		item_list.select(0)
	else:
		music = null


func update_item_list() -> void:
	item_list.clear()
	for music: RSEMusic in story.music_list.values():
		item_list.add_item(music.get_id_with_name())


func _on_line_edit_text_changed(new_text):
	if music == null:
		return
	
	music.name = new_text


func _on_item_list_item_selected(index):
	music = story.music_list.values()[index]
	selected_index = index


func _on_open_file_pressed():
	open_scene_file_dialog.show()


func _on_file_dialog_file_selected(path):
	if music == null:
		return
	
	path_label.text = path
	music.path_to_file = path


func _on_erase_pressed():
	if music == null:
		return
	
	path_label.text = ""
	music.path_to_file = ""
