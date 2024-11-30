class_name MenuElement
extends Control


signal return_was_pressed(control: Control)


@export var return_button: Button
@export var focus_element: Control


func _ready():
	if return_button != null:
		return_button.pressed.connect(return_to_menu)


func show_and_focus() -> void:
	show()
	#if focus_element != null:
		#focus_element.grab_focus()


func return_to_menu() -> void:
	return_was_pressed.emit(self)


func export_gallery_to_pot() -> void:
	pass
