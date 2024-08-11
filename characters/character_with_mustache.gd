@tool
extends RSEBaseCharacterController


@export var mustache: Node2D


func _set_special(status: bool) -> void:
	if not mustache == null:
		mustache.visible = status
