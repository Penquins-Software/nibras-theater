extends RSEBaseTransititionController


@export_file("*.tscn") var path_to_menu_scene: String


func _on_animation_player_animation_finished(_anim_name):
	get_tree().change_scene_to_file(path_to_menu_scene)
