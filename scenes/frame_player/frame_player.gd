class_name FramePlayer
extends Control


signal pause()
signal selection_started()
signal end()


const REWIND_DELAY_TIME: float = 0.02


@export var interface_container: Control
@export var text_box: TextBox
@export var selection_menu: SelectionMenu
@export var logger: Logger
@export var scene_builder: RSESceneBuilder
@export var pause_button: Button
@export var auto_play_button: TextureButton

@export var music_player: MusicPlayer
@export var bgs_player: BGSPlayer
@export var sfx_player: SFXPlayer

var local_variables: VariablesStorage

var episode: RSEEpisode
var current_frame: RSEFrame
var current_frame_index: int
var current_music: RSEMusic

## История пройденных кадров. Нужна для перемотки назад.
var history: Array

var is_gap: bool = false
var rewind_delay: float = 0.0
var rewind_block: bool = false
var auto_rewind: bool = false
var auto_play_time: float = 0.0
var auto_play: bool = false
var is_pause: bool = false
var is_transitition: bool = false

var is_mouse_on_gui: bool = false 

var speaker: RSECharacter


func _input(event):
	if episode == null:
		return
	
	if event.is_action_pressed("hide_interface"):
		switch_interface_visability()
	
	if not interface_container.visible:
		if event.is_action_pressed("cancel") or event.is_action_pressed("next_frame"):
			switch_interface_visability()
		return
	
	if is_pause:
		return
	
	if logger.visible:
		return
	
	if is_transitition:
		return
	
	if event.is_action_pressed("next_frame") and not is_mouse_on_gui:
		next_frame()
	if event.is_action("rewind"):
		_rewind()
	if event.is_action_pressed("prev_frame"):
		prev_frame()
	if event.is_action_pressed("log"):
		_show_logger()
	if event.is_action_pressed("auto_play"):
		set_auto_play(not auto_play)


func _process(delta):
	if rewind_delay > 0:
		rewind_delay -= delta
	
	if auto_play:
		if auto_play_time > 0:
			auto_play_time -= delta
			if auto_play_time <= 0:
				next_frame()
	
	if auto_rewind:
		_rewind()


func _rewind() -> void:
	if selection_menu.visible:
		return
	
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


func _start_rewind() -> void:
	auto_rewind = true


func _stop_rewind() -> void:
	auto_rewind = false


func set_episode(ep: RSEEpisode, build_first_frame: bool = true) -> void:
	selection_menu.visible = false
	is_gap = true
	scene_builder.set_episode(ep)
	episode = ep
	current_frame_index = -1
	bgs_player.clear()
	if build_first_frame:
		next_frame()


func next_frame() -> void:
	if selection_menu.visible:
		return
	
	if text_box.showing:
		text_box.end_frame() ## Принудительно закончить кадр.
		return
	
	scene_builder.camera_controller.set_smoothing(true)
	
	var prev_frame_index = current_frame_index
	current_frame_index = scene_builder.next_frame()
	if prev_frame_index == current_frame_index:
		end.emit()
		return
	if prev_frame_index > -1:
		history.append([episode.id, prev_frame_index])
	var frame: RSEFrame = episode.real_frames[current_frame_index]
	build_frame(frame)


func prev_frame() -> void:
	if selection_menu.visible:
		selection_menu.hide()
	if text_box.showing:
		text_box.end_frame() ## Принудительно закончить кадр.
	
	if history.size() <= 0:
		return
	
	scene_builder.stop_speaker(speaker)
	scene_builder.camera_controller.set_smoothing(false)
	
	var last_frame = history.pop_back()
	if episode.id != last_frame[0]:
		set_episode(RewindStoryEngine.story.episodes[last_frame[0]], false)
	
	current_frame_index = scene_builder.set_frame(last_frame[1])
	var frame: RSEFrame = episode.real_frames[current_frame_index]
	if frame is RSEFrameGap:
		prev_frame()
	elif frame is RSEFrameJump:
		prev_frame()
	elif frame is RSEFrameCondition:
		prev_frame()
	elif frame is RSEFrameVariable:
		if frame.global:
			Settings.profile.global_variables.remove_variable(frame.name)
		else:
			local_variables.remove_variable(frame.name)
		prev_frame()
	elif frame is RSEFrameTransitition:
		prev_frame()
	elif frame is RSEFrameVoice:
		prev_frame()
	elif frame is RSEFrameSFX:
		prev_frame()
	else:
		build_frame(frame, true)


func set_frame(index: int) -> void:
	current_frame_index = scene_builder.set_frame(index)
	var frame: RSEFrame = episode.real_frames[index]
	build_frame(frame)


func build_frame(frame: RSEFrame, is_immediately: bool = false) -> void:
	current_frame = frame
	if frame is RSEFrameText:
		show_text_frame(frame, is_immediately)
	elif frame is RSEFrameSelection:
		show_selection(frame)
	elif frame is RSEFrameGap:
		gap(frame)
	elif frame is RSEFrameJump:
		jump(frame)
	elif frame is RSEFrameVariable:
		variable(frame)
	elif frame is RSEFrameCondition:
		condition(frame)
	elif frame is RSEFrameTransitition:
		do_transitition(frame)
	elif frame is RSEFrameVoice:
		voice(frame)
	elif frame is RSEFrameSFX:
		sfx(frame)


func show_text_frame(frame: RSEFrameText, is_immediately: bool = false) -> void:
	speaker = RewindStoryEngine.story.characters[frame.speaker_id]
	var character = scene_builder.get_characeter_by_id(speaker.id)
	if is_immediately:
		is_gap = false
		text_box.set_text(frame.scene_state.text, speaker.display_name, speaker.color, _define_marker_mode(), is_immediately)
	else:
		if not is_gap:
			text_box.add_text(frame.text, speaker.display_name, speaker.color, _define_marker_mode())
		else:
			is_gap = false
			text_box.set_text(frame.text, speaker.display_name, speaker.color, _define_marker_mode())
		if character != null:
			character.start_talk()


func show_selection(frame: RSEFrameSelection) -> void:
	selection_menu.show_options(frame)
	rewind_block = true
	selection_started.emit()


func gap(_frame: RSEFrameGap) -> void:
	is_gap = true
	next_frame()


func jump(frame: RSEFrameJump) -> void:
	set_episode(RewindStoryEngine.story.episodes[frame.to_episode_id])


func variable(frame: RSEFrameVariable) -> void:
	if frame.global:
		Settings.profile.global_variables.add_variable(frame.name, frame.value)
	else:
		local_variables.add_variable(frame.name, frame.value)
	next_frame()


func condition(frame: RSEFrameCondition) -> void:
	var result: bool = false
	if frame.global:
		result = frame.result(Settings.profile.global_variables.data)
	else:
		result = frame.result(local_variables.data)
	print("Результат проверки условия: %s" % result)
	if result:
		next_frame()
	else:
		var real_frame_index = episode.get_next_real_frame_index(frame.end)
		set_frame(real_frame_index)


func do_transitition(frame: RSEFrameTransitition) -> void:
	is_transitition = true
	if episode.id != 95:
		text_box.clear()
		text_box.marker.hide()
	#text_box.hide()
	var transitition: RSETransitition = RewindStoryEngine.story.transititions[frame.transitition_id]
	var transitition_controller = load(transitition.path_to_scene).instantiate() as RSEBaseTransititionController
	add_child(transitition_controller)
	transitition_controller.play()
	await transitition_controller.ended
	is_transitition = false
	#text_box.show()
	next_frame()


func voice(frame: RSEFrameVoice) -> void:
	var audio = load(frame.path_to_audio)
	if audio is AudioStream:
		sfx_player.play(audio) 
	next_frame()


func sfx(frame: RSEFrameSFX) -> void:
	var audio = load(frame.path_to_audio)
	if audio is AudioStream:
		sfx_player.play(audio) 
	next_frame()


func _on_selection_menu_option_selected(option_id):
	set_episode(RewindStoryEngine.story.episodes[option_id])
	rewind_block = false


func _on_text_box_finished():
	Settings.profile.add_viewed(episode.id, current_frame_index)
	logger.add(episode.real_frames[current_frame_index])
	scene_builder.stop_speaker(speaker)
	if current_frame is RSEFrameText:
		auto_play_time = float(current_frame.text.length()) / Settings.auto_speed


func _on_pause_pressed() -> void:
	is_pause = true
	pause.emit()


func continue_play() -> void:
	is_pause = false
	text_box.show()


func _on_gui_mouse_entered():
	is_mouse_on_gui = true


func _on_gui_mouse_exited():
	is_mouse_on_gui = false


func _on_scene_builder_music(music_id: int):
	if music_id == 0:
		music_player.stop()
	
	if not RewindStoryEngine.story.music_list.has(music_id):
		return
	
	var music = RewindStoryEngine.story.music_list[music_id] as RSEMusic
	music_player.play_music(music)


func _on_scene_builder_bgs(bgs_id: int, status: bool):
	if not RewindStoryEngine.story.sound_effects.has(bgs_id):
		return
	
	var bgs = RewindStoryEngine.story.sound_effects[bgs_id] as RSESoundEffect
	
	if bgs.path_to_file == null:
		return
	
	var bgs_audio = load(bgs.path_to_file)
	if bgs_audio is AudioStream:
		if status:
			bgs_player.play(bgs_audio)
		else:
			bgs_player.stop(bgs_audio)


func _on_logger_close_pressed():
	hide_logger()


func _show_logger() -> void:
	text_box.hide()
	logger.show()


func hide_logger() -> void:
	text_box.show()
	logger.hide()


func set_auto_play(status: bool) -> void:
	auto_play = status
	auto_play_button.set_pressed_no_signal(status)
	print("Autoplay is %s" % status)


func switch_interface_visability() -> void:
	interface_container.visible = not interface_container.visible


func _define_marker_mode() -> TextBox.MarkerMode:
	if not current_frame is RSEFrameText:
		return TextBox.MarkerMode.NextFrame
	
	for index in range(current_frame_index + 1, episode.real_frames.size()):
		var frame = episode.real_frames[index]
		if frame is RSEFrameSelection:
			return TextBox.MarkerMode.NextFrame
		elif frame is RSEFrameGap:
			return TextBox.MarkerMode.NextFrame
		elif frame is RSEFrameJump:
			return TextBox.MarkerMode.NextFrame
		elif frame is RSEFrameCondition:
			return TextBox.MarkerMode.NextFrame
		elif frame is RSEFrameTransitition:
			return TextBox.MarkerMode.NextFrame
		elif frame is RSEFrameText:
			if frame.speaker_id != speaker.id:
				return TextBox.MarkerMode.NextFrame
			if text_box.get_clear_text_length() + current_frame.text.length() > text_box.MAX_SYMBOLS:
				return TextBox.MarkerMode.NextFrame
			else:
				return TextBox.MarkerMode.NextText
	
	return TextBox.MarkerMode.NextFrame
