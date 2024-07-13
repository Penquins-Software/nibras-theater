@tool
class_name GraphVisualEffect
extends StoryGraph


var visual_effect: RSEVisualEffect

var visual_effect_name: LineEdit


func _init(visual_effect: RSEVisualEffect):
	self.visual_effect = visual_effect
	id = visual_effect.id
	
	title = "Визуальный эффект"
	size = Vector2(200, 40)
	resizable = false
	
	_add_empty_slot(8)
	visual_effect_name = _add_line_edit_slot("Название эффекта").get_child(0) as LineEdit
	_add_empty_slot(8)
	_add_text_slot("ID: %s" % id)
	_add_empty_slot()
	_add_text_slot_right("[right]История", RSEStoryEditor.SlotType.VISUAL_EFFECT)
	_add_empty_slot(8)
	
	visual_effect_name.text = visual_effect.name
	
	visual_effect_name.text_changed.connect(_on_name_changed)


func _on_name_changed(new_text: String) -> void:
	visual_effect.name = new_text


func on_connect_to(to_node: GraphNode, from_port: int, to_port: int) -> void:
	visual_effect.active = true


func on_disconnect_to(to_node: GraphNode, from_port: int, to_port: int) -> void:
	visual_effect.active = false
