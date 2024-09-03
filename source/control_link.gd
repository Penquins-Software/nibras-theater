extends Control


@export var link: String


var _idle_color: Color
var _highlight_color: Color = Color(1, 0, 0)


func _enter_tree():
	_idle_color = modulate
	mouse_entered.connect(_highlight)
	mouse_exited.connect(_idle)


func _highlight() -> void:
	modulate = _highlight_color


func _idle() -> void:
	modulate = _idle_color


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_released():
			UISoundManager.click()
			OS.shell_open(link)
