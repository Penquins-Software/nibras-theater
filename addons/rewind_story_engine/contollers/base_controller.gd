@tool
class_name RSEBaseController
extends Node2D


signal reseted()


var dragger: Node2DDragger


func reset() -> void:
	reseted.emit()
