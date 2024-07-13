@tool
class_name RSEBaseVisualEffectController
extends RSEBaseController


var visual_effect: RSEVisualEffect


func reset() -> void:
	position = Vector2.ZERO
	rotation_degrees = 0
	scale = Vector2.ONE
	reseted.emit()
