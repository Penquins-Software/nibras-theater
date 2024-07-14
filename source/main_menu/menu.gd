class_name Menu
extends Control


@export_group("Menu elements")
@export var main: MenuElement

@export_group("Buttons")
@export var exit_button: Button

@export_group("Scenes")
@export_file("*.tscn") var game_scene_file


func _ready():
	main.show_and_focus()
	
	if OS.has_feature("web"):
		exit_button.hide()


func _show_menu_element(menu_element: MenuElement) -> void:
	main.hide()
	menu_element.show_and_focus()


func _show_main_menu(menu_element: Control) -> void:
	main.show_and_focus()
	menu_element.hide()


func _start_game() -> void:
	get_tree().change_scene_to_file(game_scene_file)


func exit_game() -> void:
	get_tree().quit()
