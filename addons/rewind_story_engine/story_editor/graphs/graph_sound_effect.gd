@tool
class_name GraphSoundEffect
extends StoryGraph


var sound_effect: RSESoundEffect

var sound_effect_name: LineEdit


func _init(sound_effect: RSESoundEffect):
	self.sound_effect = sound_effect
	id = sound_effect.id
	
	title = "Звуковой эффект"
	size = Vector2(200, 40)
	resizable = false
	
	_add_empty_slot(8)
	sound_effect_name = _add_line_edit_slot("Название эффекта").get_child(0) as LineEdit
	_add_empty_slot(8)
	_add_text_slot("ID: %s" % id)
	_add_empty_slot()
	_add_text_slot_right("[right]История", RSEStoryEditor.SlotType.SOUND_EFFECT)
	_add_empty_slot(8)
	
	sound_effect_name.text = sound_effect.name
	
	sound_effect_name.text_changed.connect(_on_name_changed)


func _on_name_changed(new_text: String) -> void:
	sound_effect.name = new_text


func on_connect_to(to_node: GraphNode, from_port: int, to_port: int) -> void:
	sound_effect.active = true


func on_disconnect_to(to_node: GraphNode, from_port: int, to_port: int) -> void:
	sound_effect.active = false
