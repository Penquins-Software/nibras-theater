class_name SelectionMenu
extends Control


signal option_selected(option_id: int)


@export var button_theme: Theme


func show_options(frame: RSEFrameSelection) -> void:
	_clear()
	show()
	for option in frame.options:
		var button = Button.new()
		button.theme = button_theme
		button.text = option[1]
		button.custom_minimum_size.y = 60
		button.pressed.connect(_select_option.bind(option[0]))
		add_child(button)


func _select_option(option_id: int) -> void:
	option_selected.emit(option_id)
	_clear()
	hide()


func _clear() -> void:
	for child in get_children():
		child.queue_free()
