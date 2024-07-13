@tool
class_name FrameDragger
extends TextureRect

signal dragging(value: bool)


func _gui_input(event):
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			dragging.emit(mouse_event.pressed)
