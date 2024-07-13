@tool
class_name RSEBaseLocationController
extends RSEBaseController


func reset() -> void:
	position = Vector2.ZERO
	rotation_degrees = 0
	scale = Vector2.ONE
	reseted.emit()
