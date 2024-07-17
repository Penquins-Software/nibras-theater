class_name Menu
extends Control


@export_group("Menu elements")
@export var main: MenuElement

@export_group("Buttons")
@export var exit_button: Button

@export_group("Scenes")
@export var game_scene_file: PackedScene


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
	get_tree().change_scene_to_packed(game_scene_file)


func continue_game() -> void:
	load_game(SaveManager.saves[SaveManager.saves.size() - 1])


func load_game(save: Save) -> void:
	Game.save_to_load = save
	_start_game()


func exit_game() -> void:
	get_tree().quit()
