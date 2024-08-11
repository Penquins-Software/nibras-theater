@tool
extends RSEBaseCharacterController


@export var arms: Node2D
@export var blazer: Node2D


func _set_special(status: bool) -> void:
	arms.visible = not status
	blazer.visible = status
