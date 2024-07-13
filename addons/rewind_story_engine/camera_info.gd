@tool
extends Label


@export var camera: Camera2DDragging


func _physics_process(delta):
	text = "Позиция: %.02v\nМасштабирование: %.02v" % [camera.position, camera.zoom]
