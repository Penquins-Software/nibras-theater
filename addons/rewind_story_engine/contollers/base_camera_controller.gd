@tool
class_name RSEBaseCameraController
extends RSEBaseController


var camera: Camera2D
var border: Camera2DBorder


func _init():
	camera = Camera2D.new()
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 0.075
	name = "Camera"
	add_child(camera)


func add_border() -> void:
	border = Camera2DBorder.new(camera)


func reset() -> void:
	position = Vector2.ZERO
	rotation_degrees = 0
	scale = Vector2.ONE
	camera.zoom = Vector2.ONE
	reseted.emit()
