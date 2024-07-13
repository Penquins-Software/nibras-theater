@tool
class_name RSEVisualEffectEditor
extends Control


@export var visual_effect_tem_list: ItemList

@export var visual_effect_name_line_edit: LineEdit

@export var visual_effect_open_scene_file_dialog: FileDialog
@export var visual_effect_path_label: Label

@export var visual_effect_preview_viewport: SubViewport
@export var preview_camera: Camera2DDragging

@export var preview_background: ColorRect


var story: RSEStory
var visual_effect: RSEVisualEffect : set = _set_visual_effect

var selected_index: int
var preview_visual_effect: RSEBaseVisualEffectController


func _set_visual_effect(vsl: RSEVisualEffect) -> void:
	visual_effect = vsl
	if vsl == null:
		return
	visual_effect_name_line_edit.text = vsl.name
	visual_effect_path_label.text = vsl.path_to_scene
	_set_preview()


func _set_preview() -> void:
	if is_instance_valid(preview_visual_effect):
		preview_visual_effect.queue_free()
	
	if visual_effect.path_to_scene == "":
		return
	
	if not FileAccess.file_exists(visual_effect.path_to_scene):
		return
	
	preview_visual_effect = load(visual_effect.path_to_scene).instantiate()
	visual_effect_preview_viewport.add_child(preview_visual_effect)

	#preview_character.character = character


func load_story(s: RSEStory) -> void:
	story = s
	update_item_list()
	if story.visual_effects.size() > 0:
		visual_effect = story.visual_effects.values()[0]
		visual_effect_tem_list.select(0)
	else:
		visual_effect = null


func update_item_list() -> void:
	visual_effect_tem_list.clear()
	for visual_effect: RSEVisualEffect in story.visual_effects.values():
		visual_effect_tem_list.add_item(visual_effect.get_id_with_name())


func _on_name_edit_text_changed(new_text):
	if visual_effect == null:
		return
	
	visual_effect.name = new_text


func _on_open_file_pressed():
	visual_effect_open_scene_file_dialog.show()


func _on_file_dialog_file_selected(path):
	if visual_effect == null:
		return
	
	visual_effect_path_label.text = path
	if visual_effect.path_to_scene != path:
		visual_effect.path_to_scene = path
		_set_preview()


func _on_erase_pressed():
	if visual_effect == null:
		return
	
	visual_effect_path_label.text = ""
	visual_effect.path_to_scene = ""
	_set_preview()


func _on_sub_viewport_container_gui_input(event):
	preview_camera._input(event)


func _on_reset_camera_pressed():
	preview_camera.reset()


func _on_item_list_item_selected(index):
	visual_effect = story.visual_effects.values()[index]
	selected_index = index
