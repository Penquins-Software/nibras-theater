@tool
class_name Node2DDragger
extends Node2D

signal node_changed()


var parent: RSEBaseController

var mouse_start_position: Vector2
var node_start_position: Vector2

var dragging: bool = false
var active: bool = false
var is_ctrl: bool = false


func _init(base_controller: RSEBaseController):
	parent = base_controller
	base_controller.add_child(self)
	base_controller.dragger = self


func _input(event):
	if not active:
		return
	
	#if event is InputEventKey:
		#is_ctrl = event.keycode == KEY_CTRL and event.pressed
	
	if event is InputEventMouseButton:
		_move(event)
		#if is_ctrl:
		_scale(event)
	elif event is InputEventMouseMotion:
		_drag(event)


func _move(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			mouse_start_position = event.position
			node_start_position = get_parent().position
			dragging = true
		else:
			dragging = false


func _scale(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_WHEEL_UP:
		parent.scale += Vector2(0.05, 0.05)
	elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		parent.scale -= Vector2(0.05, 0.05)
	
	if parent is RSEBaseCameraController:
		var zoom = 1 / parent.scale.x
		parent.camera.zoom = Vector2(zoom, zoom)
	
	node_changed.emit()


func _drag(event: InputEventMouseMotion) -> void:
	if dragging:
		parent.position = node_start_position - (mouse_start_position - event.position)
		node_changed.emit()


func reset() -> void:
	mouse_start_position = Vector2.ZERO
	node_start_position = Vector2.ZERO
	parent.position = Vector2.ZERO
	parent.scale = Vector2.ONE
