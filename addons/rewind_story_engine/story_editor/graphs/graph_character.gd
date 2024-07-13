@tool
class_name GraphCharacter
extends StoryGraph


var character: RSECharacter

var character_name: LineEdit


func _init(character: RSECharacter):
	self.character = character
	id = character.id
	
	title = "Персонаж"
	size = Vector2(200, 40)
	resizable = false
	
	_add_empty_slot(8)
	character_name = _add_line_edit_slot("Имя персонажа").get_child(0) as LineEdit
	_add_empty_slot(8)
	_add_text_slot("ID: %s" % id)
	_add_empty_slot()
	_add_text_slot_right("[right]История", RSEStoryEditor.SlotType.CHARACTER)
	_add_empty_slot(8)
	
	character_name.text = character.name
	
	character_name.text_changed.connect(_on_name_changed)


func _on_name_changed(new_text: String) -> void:
	character.name = new_text


func on_connect_to(to_node: StoryGraph, from_port: int, to_port: int) -> void:
	character.active = true


func on_disconnect_to(to_node: StoryGraph, from_port: int, to_port: int) -> void:
	character.active = false
