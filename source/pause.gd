class_name Pause
extends Control


signal continue_game()
signal save_game()
signal load_save(save: Save)
signal return_to_menu()


@export var main: MenuElement


func _on_continue_pressed():
	continue_game.emit()


func _on_save_pressed():
	save_game.emit()


func _on_exit_pressed():
	return_to_menu.emit()


func _show_menu_element(menu_element: MenuElement) -> void:
	main.hide()
	menu_element.show_and_focus()


func _show_main_menu(menu_element: Control) -> void:
	main.show_and_focus()
	menu_element.hide()


func _on_load_save(save: Save) -> void:
	main.show_and_focus()
	load_save.emit(save)
