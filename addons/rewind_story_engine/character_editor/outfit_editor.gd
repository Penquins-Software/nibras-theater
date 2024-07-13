@tool
class_name OutfitEditor
extends Control


signal remove_request(node: OutfitEditor)


@export var id: Label
@export var line_edit: LineEdit
@export var open_button: Button


var character: RSECharacter
var outfit_id: int 


func setting(character: RSECharacter, outfit_id: int) -> void:
	id.text = str(outfit_id)
	self.character = character
	self.outfit_id = outfit_id
	line_edit.text = character.outfits[str(outfit_id)]


func _on_line_edit_text_changed(new_text):
	character.outfits[str(outfit_id)] = new_text


func _on_remove_button_pressed():
	remove_request.emit(self)


func remove() -> void:
	character.outfits.erase(str(outfit_id))
	queue_free()
