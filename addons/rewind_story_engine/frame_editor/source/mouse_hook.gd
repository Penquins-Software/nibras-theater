@tool
class_name MouseHook
extends Control


signal up()
signal down()


func _on_up_mouse_entered():
	up.emit()


func _on_down_mouse_entered():
	down.emit()
