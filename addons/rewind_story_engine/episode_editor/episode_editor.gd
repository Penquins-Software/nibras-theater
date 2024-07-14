@tool
class_name RSEEpisodeEditor
extends Control


const FrameText: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_text.tscn")
const FrameCharacter: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_character.tscn")
const FrameLocation: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_location.tscn")
const FrameJump: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_jump.tscn")
const FrameVisualEffect: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_visual_effect.tscn")
const FrameSound: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_sound.tscn")
const FrameMusic: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_music.tscn")
const FrameVoice: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_voice.tscn")
const FrameComment: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_comment.tscn")
const FrameErase: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_erase_scene.tscn")
const FrameGap: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_gap.tscn")
const FrameSelection: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_selection.tscn")
const FrameCondition: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_condition.tscn")
const FrameSignal: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_signal.tscn")
const FrameVariable: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_variable.tscn")
const FrameEndCondition: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/frame_end_condition.tscn")


@export var frame_container: BoxContainer
@export var popup_menu: PopupMenu
@export var drag_pointer: ColorRect
@export var frame_info_label: RichTextLabel
@export var episode_item_list: ItemList
@export var episode_title_line_edit: LineEdit

var story: RSEStory

var selected_frame: FrameEditor

var selected_episode_index: int = -1

var episode: RSEEpisode : set = _set_episode

var episode_loading: bool = false


func _set_episode(ep: RSEEpisode) -> void:
	if episode == ep:
		return
	set_frame_info(null)
	if episode != null:
		save_episode()
		_clear_frames()
		await get_tree().create_timer(0.02).timeout
	episode = ep
	if episode != null:
		_load_episode()
		episode_title_line_edit.text = episode.name


func _ready():
	drag_pointer.color = EditorInterface.get_base_control().get_theme_color("accent_color", "Editor")


func _clear_frames() -> void:
	for child in frame_container.get_children():
		if child is FrameEditor:
			child.queue_free()


func _load_episode() -> void:
	if episode_loading:
		return
	
	episode_loading = true
	for frame: RSEFrame in episode.frames:
		var frame_type = frame.get_frame_type()
		match frame_type:
			RSEFrame.FrameType.Character:
				_add_frame_character(frame, false)
			RSEFrame.FrameType.Comment:
				_add_frame_comment(frame, false)
			RSEFrame.FrameType.Condition:
				_add_frame_condition(frame, false)
			RSEFrame.FrameType.EraseScene:
				_add_frame_erase_scene(frame, false)
			RSEFrame.FrameType.Jump:
				_add_frame_jump(frame, false)
			RSEFrame.FrameType.Location:
				_add_frame_location(frame, false)
			RSEFrame.FrameType.Music:
				_add_frame_music(frame, false)
			RSEFrame.FrameType.Selection:
				_add_frame_selection(frame, false)
			RSEFrame.FrameType.SignalFrame:
				_add_frame_signal(frame, false)
			RSEFrame.FrameType.SoundEffect:
				_add_frame_sound(frame, false)
			RSEFrame.FrameType.Text:
				_add_frame_text(frame, false)
			RSEFrame.FrameType.Variable:
				_add_frame_variable(frame, false)
			RSEFrame.FrameType.VisualEffect:
				_add_frame_visual_effect(frame, false)
			RSEFrame.FrameType.Voice:
				_add_frame_voice(frame, false)
			RSEFrame.FrameType.Gap:
				_add_frame_gap(frame, false)
			RSEFrame.FrameType.EndCondition:
				_add_frame_end_condition(frame, false)
	episode_loading = false


func _frame_was_selected(frame: FrameEditor) -> void:
	if selected_frame != null and selected_frame != frame:
		selected_frame.deselect()
	selected_frame = frame
	set_frame_info(frame)


func _setting_frame(frame: FrameEditor, select: bool = true) -> void:
	frame.selected.connect(_frame_was_selected)
	frame.call_popup_menu.connect(_show_popup_menu)
	frame.dragging.connect(_dragging)
	frame.under_pointer.connect(_frame_under_pointer)
	frame.updated.connect(set_frame_info)
	frame.set_index(frame_container.get_children().size() - 1)
	frame_container.add_child(frame)
	if selected_frame != null:
		frame_container.move_child(frame, selected_frame.get_index() + 1)
		update_indicies()
	if select:
		frame.select()


func _add_frame_text(f: RSEFrame = null, select: bool = true) -> FrameEditorText:
	var frame = FrameText.instantiate() as FrameEditorText
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_character(f: RSEFrame = null, select: bool = true) -> FrameEditorCharacter:
	var frame = FrameCharacter.instantiate() as FrameEditorCharacter
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_location(f: RSEFrame = null, select: bool = true) -> FrameEditorLocation:
	var frame = FrameLocation.instantiate() as FrameEditorLocation
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_jump(f: RSEFrame = null, select: bool = true) -> FrameEditorJump:
	var frame = FrameJump.instantiate() as FrameEditorJump
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_visual_effect(f: RSEFrame = null, select: bool = true) -> FrameEditorVisualEffect:
	var frame = FrameVisualEffect.instantiate() as FrameEditorVisualEffect
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_sound(f: RSEFrame = null, select: bool = true) -> FrameEditorSound:
	var frame = FrameSound.instantiate() as FrameEditorSound
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_music(f: RSEFrame = null, select: bool = true) -> FrameEditorMusic:
	var frame = FrameMusic.instantiate() as FrameEditorMusic
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_voice(f: RSEFrame = null, select: bool = true) -> FrameEditorVoice:
	var frame = FrameVoice.instantiate() as FrameEditorVoice
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_gap(f: RSEFrame = null, select: bool = true) -> FrameEditorGap:
	var frame = FrameGap.instantiate() as FrameEditorGap
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_end_condition(f: RSEFrame = null, select: bool = true) -> FrameEditorEndCondition:
	var frame = FrameEndCondition.instantiate() as FrameEditorEndCondition
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_comment(f: RSEFrame = null, select: bool = true) -> FrameEditorComment:
	var frame = FrameComment.instantiate() as FrameEditorComment
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_condition(f: RSEFrame = null, select: bool = true) -> FrameEditorCondition:
	var frame = FrameCondition.instantiate() as FrameEditorCondition
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_erase_scene(f: RSEFrame = null, select: bool = true) -> FrameEditorEraseScene:
	var frame = FrameErase.instantiate() as FrameEditorEraseScene
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_selection(f: RSEFrame = null, select: bool = true) -> FrameEditorSelection:
	var frame = FrameSelection.instantiate() as FrameEditorSelection
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_signal(f: RSEFrame = null, select: bool = true) -> FrameEditorSignal:
	var frame = FrameSignal.instantiate() as FrameEditorSignal
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _add_frame_variable(f: RSEFrame = null, select: bool = true) -> FrameEditorVariable:
	var frame = FrameVariable.instantiate() as FrameEditorVariable
	frame.setting(story, f)
	_setting_frame(frame, select)
	return frame


func _show_popup_menu() -> void:
	popup_menu.show()
	popup_menu.position = get_screen_position() + get_local_mouse_position()


func _popup_menu_id_pressed(id: int) -> void:
	match id:
		0:
			_double_frame()
		2:
			_up_frame()
		3:
			_down_frame()
		5:
			_remove_frame()


func _double_frame() -> void:
	update_indicies()
	pass


func _up_frame() -> void:
	var index: int = selected_frame.get_index() - 1
	if index == drag_pointer.get_index():
		index -= 1
	if index < 0:
		index = 0
	frame_container.move_child(selected_frame, index)
	update_indicies()


func _down_frame() -> void:
	var index: int = selected_frame.get_index() + 1
	if index == drag_pointer.get_index():
		index += 1
	frame_container.move_child(selected_frame, index)
	update_indicies()


func _remove_frame() -> void:
	selected_frame.queue_free()
	selected_frame = null
	await get_tree().create_timer(0.02).timeout
	update_indicies()


func _dragging(frame: FrameEditor, value: bool) -> void:
	if value:
		_start_drag(frame)
	else:
		_end_drag()


func _frame_under_pointer(frame: FrameEditor) -> void:
	if drag_pointer.visible:
		frame_container.move_child(drag_pointer, frame.get_index())


func _start_drag(frame: FrameEditor) -> void:
	drag_pointer.show()
	if drag_pointer.get_index() != frame.get_index() + 1:
		var index: int = 0
		if drag_pointer.get_index() >= frame.get_index():
			index = frame.get_index() + 1
		else:
			index = frame.get_index()
		frame_container.move_child(drag_pointer, index)


func _end_drag() -> void:
	drag_pointer.hide()
	frame_container.move_child(selected_frame, drag_pointer.get_index())
	update_indicies()


func save_episode() -> void:
	if episode != null:
		episode.frames = get_frames()
		#episode.create_scene_state_for_every_frame()


func get_frames() -> Array[RSEFrame]:
	var frames: Array[RSEFrame] = []
	for child in frame_container.get_children():
		if child is FrameEditor:
			frames.append(child.get_frame())
	return frames


func update_indicies() -> void:
	var count: int = 0
	for child in frame_container.get_children():
		if child is FrameEditor:
			(child as FrameEditor).set_index(count)
			count += 1


func _get_local_scene_state() -> RSESceneState:
	if selected_frame == null:
		return
	
	var scene_state := RSESceneState.new()
	
	var frames = get_frames()
	for index in range(0, selected_frame.index):
		if frames.size() > index:
			frames[index].write_frame_info_to_scene_state(scene_state)
	
	return scene_state


func set_frame_info(frame: FrameEditor = null) -> void:
	if frame == null:
		frame_info_label.text = "-"
		return
	
	var scene_state = _get_local_scene_state()
	frame_info_label.text = "Номер кадра: %s" % frame.index
	
	if scene_state.location_id > -1 and story.locations.has(scene_state.location_id):
		frame_info_label.text += "\nЛокация: %s" % story.locations[scene_state.location_id].name
	else:
		frame_info_label.text += "\nЛокация: -"
	
	var characters: Array[String] = []
	for char_id: int in scene_state.characters:
		if story.characters.has(char_id):
			characters.append(story.characters[char_id].name)
	frame_info_label.text += "\nПерсонажи: %s" % str(characters)
	
	var visual_effects: Array[String] = []
	for visual_effect_id: int in scene_state.visual_effect_ids:
		if story.visual_effects.has(visual_effect_id):
			visual_effects.append(story.visual_effects[visual_effect_id].name)
	frame_info_label.text += "\nВизуальные эффекты: %s" % str(visual_effects)
	
	var sound_effects: Array[String] = []
	for sound_effect_id: int in scene_state.sound_effect_ids:
		if story.sound_effects.has(sound_effect_id):
			sound_effects.append(story.sound_effects[sound_effect_id].name)
	frame_info_label.text += "\nЗвуковые эффекты: %s" % str(sound_effects)
	
	var music = "-"
	if story.music_list.has(scene_state.music_id):
		music = story.music_list[scene_state.music_id].name
	frame_info_label.text += "\nМузыка: %s" % str(music)
	
	var variables = "-"
	if not scene_state.variables.is_empty():
		variables = str(scene_state.variables)
	frame_info_label.text += "\nПеременные: %s" % str(variables)


func load_story(s: RSEStory) -> void:
	story = s
	update_item_list()
	if story.episodes.size() > 0:
		episode = story.episodes.values()[0]
		episode_item_list.select(0)
	else:
		episode = null


func update_item_list(episode_index: int = -1) -> void:
	episode_item_list.clear()
	for episode: RSEEpisode in story.episodes.values():
		episode_item_list.add_item(episode.get_id_with_name())
	if episode_index > -1:
		selected_episode_index = episode_index
	if selected_episode_index > -1:
		episode_item_list.select(selected_episode_index)


func _on_episode_item_list_item_selected(index):
	episode = story.episodes.values()[index]
	selected_episode_index = index


func update_current_episode() -> void:
	set_frame_info(null)
	if episode != null:
		_clear_frames()
		await get_tree().create_timer(0.02).timeout
		_load_episode()


func _on_episode_name_text_changed(new_text):
	if episode == null:
		return
	
	episode.name = new_text
