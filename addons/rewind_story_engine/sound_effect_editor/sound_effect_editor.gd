@tool
class_name RSESoundEffectEditor
extends Control


@export var item_list: ItemList

@export var name_line_edit: LineEdit

@export var open_scene_file_dialog: FileDialog
@export var path_label: Label


var story: RSEStory
var sound_effect: RSESoundEffect : set = _set_sound_effect

var selected_index: int


func _set_sound_effect(snd: RSESoundEffect) -> void:
	sound_effect = snd
	if snd == null:
		return
	name_line_edit.text = snd.name
	path_label.text = snd.path_to_file


func load_story(s: RSEStory) -> void:
	story = s
	update_item_list()
	if story.sound_effects.size() > 0:
		sound_effect = story.sound_effects.values()[0]
		item_list.select(0)
	else:
		sound_effect = null


func update_item_list() -> void:
	item_list.clear()
	for sound_effect: RSESoundEffect in story.sound_effects.values():
		item_list.add_item(sound_effect.get_id_with_name())


func _on_line_edit_text_changed(new_text):
	if sound_effect == null:
		return
	
	sound_effect.name = new_text


func _on_item_list_item_selected(index):
	sound_effect = story.sound_effects.values()[index]
	selected_index = index


func _on_open_file_pressed():
	open_scene_file_dialog.show()


func _on_file_dialog_file_selected(path):
	if sound_effect == null:
		return
	
	path_label.text = path
	sound_effect.path_to_file = path


func _on_erase_pressed():
	if sound_effect == null:
		return
	
	path_label.text = ""
	sound_effect.path_to_file = ""
