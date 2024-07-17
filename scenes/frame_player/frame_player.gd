class_name FramePlayer
extends Control


signal pause()


const REWIND_DELAY_TIME: float = 0.02


@export var text_box: TextBox
@export var selection_menu: SelectionMenu
@export var logger: Logger
@export var scene_builder: RSESceneBuilder
@export var pause_button: Button

var episode: RSEEpisode
var current_frame_index: int

var is_gap: bool = false
var rewind_delay: float = 0.0
var rewind_block: bool = false
var is_pause: bool = false

var is_mouse_on_gui: bool = false 

var speaker: RSECharacter


func _input(event):
	if episode == null:
		return
	
	if is_pause:
		return
	
	if logger.visible:
		return
	
	if selection_menu.visible:
		return
	
	if event.is_action_pressed("next_frame") and not is_mouse_on_gui:
		if text_box.showing:
			text_box.end_frame() ## Принудительно закончить кадр.
		else: ## Переключиться на следующий кадр.
			next_frame()
	if event.is_action("rewind"):
		_rewind()
	if event.is_action_pressed("prev_frame") or event.is_action_pressed("log"):
		logger.show()
		#pause_button.visible = false
		#prev_frame()
	if event.is_action_pressed("hide_interface"):
		pass


func _process(delta):
	if rewind_delay > 0:
		rewind_delay -= delta


func _rewind() -> void:
	if rewind_block:
		return
	
	if rewind_delay <= 0:
		rewind_delay = REWIND_DELAY_TIME
		if Settings.rewind_mode == Settings.RewindMode.Full:
			text_box.end_frame()
			next_frame()
		elif Settings.rewind_mode == Settings.RewindMode.Viewed:
			if Settings.profile.is_viewed(episode.id, current_frame_index):
				text_box.end_frame()
				next_frame()


func set_episode(ep: RSEEpisode, build_first_frame: bool = true) -> void:
	selection_menu.visible = false
	is_gap = true
	scene_builder.set_episode(ep)
	episode = ep
	if build_first_frame:
		next_frame()


func next_frame() -> void:
	current_frame_index = scene_builder.next_frame()
	var frame: RSEFrame = episode.real_frames[current_frame_index]
	build_frame(frame)


func prev_frame() -> void:
	current_frame_index = scene_builder.prev_frame()
	var frame: RSEFrame = episode.real_frames[current_frame_index]
	if frame is RSEFrameGap:
		current_frame_index = scene_builder.prev_frame()
		frame = episode.real_frames[current_frame_index]
	build_frame(frame, true)


func set_frame(index: int) -> void:
	current_frame_index = scene_builder.set_frame(index)
	var frame: RSEFrame = episode.real_frames[index]
	build_frame(frame)


func build_frame(frame: RSEFrame, is_immediately: bool = false) -> void:
	if frame is RSEFrameText:
		show_text_frame(frame, is_immediately)
	if frame is RSEFrameSelection:
		show_selection(frame)
	if frame is RSEFrameGap:
		gap(frame)
	if frame is RSEFrameJump:
		jump(frame)


func show_text_frame(frame: RSEFrameText, is_immediately: bool = false) -> void:
	speaker = RewindStoryEngine.story.characters[frame.speaker_id]
	if is_immediately:
		is_gap = false
		text_box.set_text(frame.scene_state.text, speaker.display_name, speaker.color, TextBox.MarkerMode.NextText, is_immediately)
	else:
		if not is_gap:
			text_box.add_text(frame.text, speaker.display_name, speaker.color, TextBox.MarkerMode.NextText)
		else:
			is_gap = false
			text_box.set_text(frame.text, speaker.display_name, speaker.color, TextBox.MarkerMode.NextText)
	var character = scene_builder.get_characeter_by_id(speaker.id)
	if character != null:
		character.start_talk()


func show_selection(frame: RSEFrameSelection) -> void:
	selection_menu.show_options(frame)
	rewind_block = true


func gap(_frame: RSEFrameGap) -> void:
	is_gap = true
	next_frame()


func jump(frame: RSEFrameJump) -> void:
	set_episode(RewindStoryEngine.story.episodes[frame.to_episode_id])


func _on_selection_menu_option_selected(option_id):
	set_episode(RewindStoryEngine.story.episodes[option_id])
	rewind_block = false


func _on_text_box_finished():
	Settings.profile.add_viewed(episode.id, current_frame_index)
	logger.add(episode.real_frames[current_frame_index])
	var character = scene_builder.get_characeter_by_id(speaker.id)
	if character != null:
		character.stop_talk()


func _on_pause_pressed() -> void:
	is_pause = true
	pause.emit()


func continue_play() -> void:
	is_pause = false


func _on_pause_mouse_entered():
	is_mouse_on_gui = true


func _on_pause_mouse_exited():
	is_mouse_on_gui = false
