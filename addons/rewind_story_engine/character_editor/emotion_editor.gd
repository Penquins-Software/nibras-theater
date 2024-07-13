@tool
class_name EmotionEditor
extends Control


signal remove_request(node: EmotionEditor)


@export var id: Label
@export var line_edit: LineEdit
@export var open_button: Button


var character: RSECharacter
var emotion_id: int 


func setting(character: RSECharacter, emotion_id: int) -> void:
	id.text = str(emotion_id)
	self.character = character
	self.emotion_id = emotion_id
	line_edit.text = character.emotions[str(emotion_id)]


func _on_line_edit_text_changed(new_text):
	character.emotions[str(emotion_id)] = new_text


func _on_remove_button_pressed():
	remove_request.emit(self)


func remove() -> void:
	character.emotions.erase(str(emotion_id))
	queue_free()
