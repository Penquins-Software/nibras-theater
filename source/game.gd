class_name Game
extends Node


static var save_to_load: Save


@export var frame_player: FramePlayer
@export var pause_menu: Pause

@export_file("*.tscn") var path_to_menu_scene: String

var screenshoot: Image

var local_variables: Dictionary


func _ready():
	if save_to_load != null:
		load_save(save_to_load)
		save_to_load = null
	else:
		new_game()


func new_game() -> void:
	frame_player.set_episode(RewindStoryEngine.story.start_episode)


func load_save(save: Save) -> void:
	var episode = RewindStoryEngine.story.episodes[save.episode_id]
	frame_player.set_episode(episode, false)
	frame_player.set_frame(save.frame_index)
	local_variables = save.local_variables
	continue_game()


func make_save() -> void:
	SaveManager.create_save(screenshoot, frame_player.episode.id, frame_player.current_frame_index, local_variables)
	continue_game()


func pause_game() -> void:
	screenshoot = get_viewport().get_texture().get_image()
	pause_menu.visible = true
	frame_player.process_mode = Node.PROCESS_MODE_DISABLED


func continue_game() -> void:
	pause_menu.visible = false
	frame_player.process_mode = Node.PROCESS_MODE_INHERIT
	frame_player.continue_play()


func return_to_menu() -> void:
	get_tree().change_scene_to_file(path_to_menu_scene)
