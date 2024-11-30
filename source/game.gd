class_name Game
extends Node


static var save_to_load: Save


@export var frame_player: FramePlayer
@export var pause_menu: Pause

@export_file("*.tscn") var path_to_menu_scene: String

var screenshoot: Image

var local_variables: VariablesStorage = VariablesStorage.new()


func _ready():
	frame_player.local_variables = local_variables
	if save_to_load != null:
		load_save(save_to_load)
		save_to_load = null
	else:
		new_game()


func new_game() -> void:
	frame_player.set_episode(RewindStoryEngine.story.start_episode)


func load_save(save: Save) -> void:
	var episode = RewindStoryEngine.story.episodes[save.episode_id]
	frame_player.music_player.stream = null
	frame_player.set_episode(episode, false)
	frame_player.set_frame(save.frame_index)
	frame_player.history.clear()
	local_variables.data = save.local_variables
	print("Save local variables: %s" % local_variables)
	continue_game()


func make_save() -> void:
	SaveManager.create_save(screenshoot, frame_player.episode.id, frame_player.current_frame_index, local_variables.data)
	continue_game()


func _on_frame_player_selection_started():
	pass
	#screenshoot = get_viewport().get_texture().get_image()
	#SaveManager.create_autosave(screenshoot, frame_player.episode.id, frame_player.current_frame_index, local_variables.data)


func pause_game() -> void:
	screenshoot = get_viewport().get_texture().get_image()
	pause_menu.visible = true
	frame_player.process_mode = Node.PROCESS_MODE_DISABLED


func continue_game() -> void:
	pause_menu.visible = false
	frame_player.process_mode = Node.PROCESS_MODE_INHERIT
	frame_player.continue_play()


func return_to_menu() -> void:
	SaveManager.create_autosave(screenshoot, frame_player.episode.id, frame_player.current_frame_index, local_variables.data)
	get_tree().change_scene_to_file(path_to_menu_scene)


func _on_frame_player_end():
	get_tree().change_scene_to_file(path_to_menu_scene)


func _input(event):
	if event.is_action_pressed("pause"):
		UISoundManager.click()
		if pause_menu.visible:
			continue_game()
		else:
			pause_game()
