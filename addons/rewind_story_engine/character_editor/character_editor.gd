@tool
class_name RSECharacterEditor
extends Control


const EmotionEditorScene: PackedScene = preload("res://addons/rewind_story_engine/character_editor/emotion_editor.tscn")
const OutfitEditorScene: PackedScene = preload("res://addons/rewind_story_engine/character_editor/outfit_editor.tscn")

const EMOTION_TEXT: String = "Эмоция: %s"
const OUTFIT_TEXT: String = "Костюм: %s"


@export var character_item_list: ItemList

@export var character_name_line_edit: LineEdit
@export var character_display_name_line_edit: LineEdit
@export var character_display_name_checkbox: CheckBox

@export var character_color_picker_button: ColorPickerButton

@export var character_open_scene_file_dialog: FileDialog
@export var character_path_label: Label

@export var emotion_container: Control
@export var outfit_container: Control

@export var character_preview_viewport: SubViewport
@export var character_preview_camera: Camera2DDragging

@export var character_preview_emotion_label: Label
@export var character_preview_outfit_label: Label

@export var confirmation_dialog: ConfirmationDialog


var story: RSEStory
var character: RSECharacter : set = _set_character

var selected_index: int
var preview_character: RSEBaseCharacterController

var remove_request_sender


func _set_character(ch: RSECharacter) -> void:
	character = ch
	if ch == null:
		return
	character_name_line_edit.text = ch.name
	character_display_name_line_edit.text = ch.display_name
	character_display_name_checkbox.button_pressed = ch.main_name_for_display_name
	character_color_picker_button.color = ch.color
	character_path_label.text = ch.path_to_scene
	_set_emotions()
	_set_outfits()
	_set_preview()


func _set_preview() -> void:
	if is_instance_valid(preview_character):
		preview_character.queue_free()

	character_preview_emotion_label.text = EMOTION_TEXT % "-"
	character_preview_outfit_label.text = OUTFIT_TEXT % "-"
	
	if character.path_to_scene == "":
		return
	
	if not FileAccess.file_exists(character.path_to_scene):
		return
	
	preview_character = load(character.path_to_scene).instantiate()
	character_preview_viewport.add_child(preview_character)

	preview_character.character = character

	if character.emotions.size() > 0:
		_preview_emotion(int(character.emotions.keys()[0]))

	if character.outfits.size() > 0:
		_preview_outfit(int(character.outfits.keys()[0]))


func load_story(s: RSEStory) -> void:
	story = s
	update_item_list()
	if story.characters.size() > 0:
		character = story.characters.values()[0]
		character_item_list.select(0)
	else:
		character = null


func update_item_list() -> void:
	character_item_list.clear()
	for character: RSECharacter in story.characters.values():
		character_item_list.add_item(character.get_id_with_name())


func _on_character_name_text_changed(new_text):
	if character == null:
		return
	
	character.name = new_text
	if character.main_name_for_display_name:
		character_display_name_line_edit.text = new_text


func _on_display_name_line_edit_text_changed(new_text):
	if character == null:
		return
	
	character.display_name = new_text


func _on_display_name_check_box_toggled(toggled_on: bool):
	character_display_name_line_edit.editable = not toggled_on
	character.main_name_for_display_name = toggled_on
	if toggled_on:
		character_display_name_line_edit.text = character.name
		character.display_name = character.name


func _on_character_item_list_item_selected(index):
	character = story.characters.values()[index]
	selected_index = index


func _on_sub_viewport_container_gui_input(event):
	character_preview_camera._input(event)


func _on_reset_camera_pressed():
	character_preview_camera.reset()


func _on_eyes_animation_toggled(toggled_on):
	if preview_character == null:
		return

	preview_character.set_blinking(toggled_on)


func _on_mouth_animation_toggled(toggled_on):
	if preview_character == null:
		return

	if toggled_on:
		preview_character.start_talk()
	else:
		preview_character.stop_talk()


func _on_open_scene_pressed():
	character_open_scene_file_dialog.show()


func _on_scene_dialog_file_selected(path):
	if character == null:
		return

	character_path_label.text = path
	if character.path_to_scene != path:
		character.path_to_scene = path
		_set_preview()


func _on_erase_pressed():
	if character == null:
		return
	
	character_path_label.text = ""
	character.path_to_scene = ""
	_set_preview()


func _set_emotions() -> void:
	_clear_emotion_list()
	for emotion_id in character.emotions:
		_add_emotion(int(emotion_id))


func _set_outfits() -> void:
	_clear_outfit_list()
	for outfit_id in character.outfits:
		_add_outfit(int(outfit_id))


func _clear_emotion_list() -> void:
	_clear_container_exclude_button(emotion_container)


func _clear_outfit_list() -> void:
	_clear_container_exclude_button(outfit_container)


func _clear_container_exclude_button(container: Control) -> void:
	for child in container.get_children():
		if not child is Button:
			child.queue_free() 


func _add_emotion(id: int) -> void:
	var emotion_editor = EmotionEditorScene.instantiate() as EmotionEditor
	emotion_editor.setting(character, id)
	emotion_container.add_child(emotion_editor)
	emotion_container.move_child(emotion_editor, emotion_container.get_child_count() - 2)
	emotion_editor.open_button.pressed.connect(_preview_emotion.bind(emotion_editor.emotion_id))
	emotion_editor.remove_request.connect(_remove_requset)


func _add_outfit(id: int) -> void:
	var outfit_editor = OutfitEditorScene.instantiate() as OutfitEditor
	outfit_editor.setting(character, id)
	outfit_container.add_child(outfit_editor)
	outfit_container.move_child(outfit_editor, outfit_container.get_child_count() - 2)
	outfit_editor.open_button.pressed.connect(_preview_outfit.bind(outfit_editor.outfit_id))
	outfit_editor.remove_request.connect(_remove_requset)


func _on_add_emotion_button_pressed():
	var id = character.add_emotion()
	_add_emotion(id)


func _on_add_outfit_button_pressed():
	var id = character.add_outfit()
	_add_outfit(id)


func _preview_emotion(id: int) -> void:
	character_preview_emotion_label.text = EMOTION_TEXT % character.emotions[str(id)]
	if preview_character != null:
		preview_character.set_emotion(id)
		if preview_character.mouth != null and preview_character.mouth.is_playing():
			preview_character.start_talk()



func _preview_outfit(id: int) -> void:
	character_preview_outfit_label.text = OUTFIT_TEXT % character.outfits[str(id)]


func _on_color_picker_color_changed(color: Color):
	character.color = color


func _remove_requset(sender) -> void:
	remove_request_sender = sender
	confirmation_dialog.show()


func _on_confirmation_dialog_confirmed():
	remove_request_sender.remove()
