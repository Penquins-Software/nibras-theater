@tool
extends RSEBaseCharacterController


@export var normal: Node2D
@export var damaged: Node2D

@export var normal_eyes: AnimatedSprite2D
@export var normal_mouth: AnimatedSprite2D
@export var special_eyes: AnimatedSprite2D
@export var special_mouth: AnimatedSprite2D


func _set_special(status: bool) -> void:
	normal.visible = not status
	damaged.visible = status
	if status:
		eyes = special_eyes
		mouth = special_mouth
	else:
		eyes = normal_eyes
		mouth = normal_mouth
