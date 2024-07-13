@tool
class_name StoryGraph
extends GraphNode


signal double_click(graph_node: StoryGraph)


var id: int = 0


func _add_empty_slot(slot_size: int = 24) -> Control:
	var slot = Control.new()
	slot.custom_minimum_size.y = slot_size
	
	add_child(slot)
	
	return slot


func _add_text_slot(text: String, type: RSEStoryEditor.SlotType = RSEStoryEditor.SlotType.NONE) -> Control:
	var slot = MarginContainer.new()
	slot.custom_minimum_size.y = 24
	
	var label = RichTextLabel.new()
	label.text = text
	label.bbcode_enabled = true
	
	slot.add_child(label)
	add_child(slot)
	
	return slot


func _add_line_edit_slot(placeholder_text: String, type: RSEStoryEditor.SlotType = RSEStoryEditor.SlotType.NONE) -> Control:
	var slot = MarginContainer.new()
	slot.custom_minimum_size.y = 24
	
	var line_edit = LineEdit.new()
	line_edit.placeholder_text = placeholder_text
	
	slot.add_child(line_edit)
	add_child(slot)
	
	return slot


func _add_text_edit_slot(placeholder_text: String, type: RSEStoryEditor.SlotType = RSEStoryEditor.SlotType.NONE) -> Control:
	var slot = MarginContainer.new()
	slot.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	var text_edit = TextEdit.new()
	text_edit.placeholder_text = placeholder_text
	text_edit.wrap_mode = TextEdit.LINE_WRAPPING_BOUNDARY
	
	slot.add_child(text_edit)
	add_child(slot)
	
	return slot


func _add_text_slot_left(text: String, type: RSEStoryEditor.SlotType) -> Control:
	var slot = _add_text_slot(text, type)
	_make_slot_left(slot, type)
	return slot


func _add_text_slot_right(text: String, type: RSEStoryEditor.SlotType) -> Control:
	var slot = _add_text_slot(text, type)
	_make_slot_right(slot, type)
	return slot


func _make_slot_left(slot: Control, type: RSEStoryEditor.SlotType) -> void:
	var index = slot.get_index()
	set_slot_enabled_left(index, true)
	set_slot_type_left(index, type)
	set_slot_color_left(index, RSEStoryEditor.SlotColors[type])


func _make_slot_right(slot: Control, type: RSEStoryEditor.SlotType) -> void:
	var index = slot.get_index()
	set_slot_enabled_right(index, true)
	set_slot_type_right(index, type)
	set_slot_color_right(index, RSEStoryEditor.SlotColors[type])


func on_connect_from(from_node: StoryGraph, from_port: int, to_port: int) -> void:
	pass


func on_connect_to(to_node: StoryGraph, from_port: int, to_port: int) -> void:
	pass


func on_disconnect_from(from_node: StoryGraph, from_port: int, to_port: int) -> void:
	pass


func on_disconnect_to(to_node: StoryGraph, from_port: int, to_port: int) -> void:
	pass


func delete() -> void:
	queue_free()


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
			double_click.emit(self)
