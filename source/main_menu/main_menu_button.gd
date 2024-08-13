extends ButtonWithSound


signal menu_element_was_selected(menu_element: MenuElement)


@export var menu_element_to_show: MenuElement


func _pressed():
	_play_sound()
	if menu_element_to_show != null:
		menu_element_was_selected.emit(menu_element_to_show)
