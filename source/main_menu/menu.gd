class_name Menu
extends Control


static var menu_scene: PackedScene


@export_group("Menu elements")
@export var main: MenuElement

@export_group("Buttons")
@export var gallery_button: Button
@export var extra_button: Button
@export var saves_button: Button
@export var exit_button: Button

@export_group("Scenes")
@export var game_scene_file: PackedScene

@export_group("Other")
@export var select_episode: SelectEpisode
@export var episode_new: Control
@export var gallery_new: Control
@export var gallery_items_container: Control


func _ready():
	main.show_and_focus()
	
	gallery_button.disabled = not Settings.profile.global_variables.is_variable("FIRST_EPISODE")
	extra_button.disabled = not Settings.profile.global_variables.is_variable("TRUE_ENDING")
	saves_button.disabled = SaveManager.saves.size() == 0
	
	if OS.has_feature("web"):
		exit_button.hide()
	
	#check_episodes()
	check_gallery_items()


func _show_menu_element(menu_element: MenuElement) -> void:
	main.hide()
	menu_element.show_and_focus()


func _show_main_menu(menu_element: Control) -> void:
	main.show_and_focus()
	menu_element.hide()


func _start_game() -> void:
	get_tree().change_scene_to_packed(game_scene_file)


func continue_game() -> void:
	if Settings.last_save != "":
		load_game(Save.load_from_file(Settings.last_save))
	else:
		load_game(SaveManager.saves[SaveManager.saves.size() - 1])


func load_game(save: Save) -> void:
	Game.save_to_load = save
	_start_game()


func exit_game() -> void:
	get_tree().quit()


func _on_return_from_gallery_pressed():
	check_gallery_items()


func check_episodes() -> void:
	episode_new.hide()
	if select_episode.has_not_viewed():
		episode_new.show()


func check_gallery_items() -> void:
	gallery_new.hide()
	for child: GalleryItem in gallery_items_container.get_children():
		if child.new:
			gallery_new.show()
			return


func _on_start_game_pressed():
	pass # Replace with function body.
