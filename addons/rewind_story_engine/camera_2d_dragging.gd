@tool
class_name Camera2DDragging
extends Camera2D

var mouse_start_position: Vector2
var screen_start_position: Vector2

var dragging: bool = false


func _input(event):
	if event is InputEventMouseButton:
		_move(event)
		_zoom(event)
	elif event is InputEventMouseMotion:
		_drag(event)


func _move(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			mouse_start_position = event.position
			screen_start_position = position
			dragging = true
		else:
			dragging = false


func _zoom(event: InputEventMouseButton) -> void:
	var result_zoom: Vector2
	if event.button_index == MOUSE_BUTTON_WHEEL_UP:
		result_zoom = zoom + Vector2(0.05, 0.05)
	elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		result_zoom = zoom - Vector2(0.05, 0.05)
	if result_zoom.x > 0:
		zoom = result_zoom


func _drag(event: InputEventMouseMotion) -> void:
	if dragging:
		position = (mouse_start_position - event.position) + screen_start_position


func reset() -> void:
	mouse_start_position = Vector2.ZERO
	screen_start_position = Vector2.ZERO
	position = Vector2.ZERO
	zoom = Vector2.ONE
