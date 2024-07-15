extends Control


@export var main_menu: PackedScene


func _input(event):
	if event.is_action_pressed("next_frame"):
		_load_main_menu()


func _on_animation_player_animation_finished(_anim_name):
	_load_main_menu()


func _load_main_menu() -> void:
	get_tree().change_scene_to_packed(main_menu)
