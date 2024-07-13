@tool
class_name GraphLocation
extends StoryGraph


var location: RSELocation

var location_name: LineEdit


func _init(location: RSELocation):
	self.location = location
	id = location.id
	
	title = "Локация"
	size = Vector2(200, 40)
	resizable = false
	
	_add_empty_slot(8)
	location_name = _add_line_edit_slot("Название локации").get_child(0) as LineEdit
	_add_empty_slot(8)
	_add_text_slot("ID: %s" % id)
	_add_empty_slot()
	_add_text_slot_right("[right]История", RSEStoryEditor.SlotType.LOCATION)
	_add_empty_slot(8)
	
	location_name.text = location.name
	
	location_name.text_changed.connect(_on_name_changed)


func _on_name_changed(new_text: String) -> void:
	location.name = new_text


func on_connect_to(to_node: GraphNode, from_port: int, to_port: int) -> void:
	location.active = true


func on_disconnect_to(to_node: GraphNode, from_port: int, to_port: int) -> void:
	location.active = false
