extends Button


signal menu_element_was_selected(menu_element: MenuElement)


@export var menu_element_to_show: MenuElement


func _pressed():
	menu_element_was_selected.emit(menu_element_to_show)
