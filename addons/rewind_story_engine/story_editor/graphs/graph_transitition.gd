@tool
class_name GraphTransitition
extends StoryGraph


var transitition: RSETransitition

var location_name: LineEdit


func _init(transitition: RSETransitition):
	self.transitition = transitition
	id = transitition.id
	
	title = "Переход"
	size = Vector2(200, 40)
	resizable = false
	
	_add_empty_slot(8)
	location_name = _add_line_edit_slot("Название перехода").get_child(0) as LineEdit
	_add_empty_slot(8)
	_add_text_slot("ID: %s" % id)
	_add_empty_slot()
	_add_text_slot_right("[right]История", RSEStoryEditor.SlotType.TRANSITITION)
	_add_empty_slot(8)
	
	location_name.text = transitition.name
	
	location_name.text_changed.connect(_on_name_changed)


func _on_name_changed(new_text: String) -> void:
	transitition.name = new_text


func on_connect_to(to_node: GraphNode, from_port: int, to_port: int) -> void:
	transitition.active = true


func on_disconnect_to(to_node: GraphNode, from_port: int, to_port: int) -> void:
	transitition.active = false
