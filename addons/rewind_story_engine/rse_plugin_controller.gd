@tool
class_name RSEPluginController
extends Control


enum Mode {
	History,
	Episode,
	Character,
	Location,
	VisualEffect,
	SoundEffect,
	Music,
	Transitition,
	Scene,
	Player,
}


@export var start_screen: Control
@export var work_screen: Control

@export var tab_container: TabContainer

@export_category("File Dialoges")
@export var create_file_dialog: FileDialog
@export var open_file_dialog: FileDialog
@export var save_file_dialog: FileDialog
@export var save_pot_dialog: FileDialog

@export_category("Tabs")
@export var story_editor: RSEStoryEditor
@export var episode_editor: RSEEpisodeEditor
@export var character_editor: RSECharacterEditor
@export var location_editor: RSELocationEditor
@export var visual_effect_editor: RSEVisualEffectEditor
@export var sound_effect_editor: RSESoundEffectEditor
@export var music_editor: RSEMusicEditor
@export var transitition_editor: RSETransititionEditor
@export var scene_editor: RSESceneEditor

var current_mode: Mode = Mode.History

var story: RSEStory : set = _set_story

func _set_story(s: RSEStory) -> void:
	story = s
	RewindStoryEngine.story = s
	if story != null:
		_show_work_screen()
		_set_story_editor()
		_set_episode_editor()
		_set_character_editor()
		_set_location_editor()
		_set_visual_effect_editor()
		_set_sound_effect_editor()
		_set_music_editor()
		_set_transitition_editor()
		_set_scene_editor()
	else:
		_show_start_screen()


func _ready():
	story_editor.open_edit_episode.connect(open_episode)


func _on_file_id_pressed(id):
	match id:
		0:
			## Создать историю.
			create_story()
		1:
			## Открыть.
			load_story()
		3:
			## Сохранить.
			save_story()
		4:
			## Сохранить как.
			save_as_story()
		7:
			## Сгенерировать POT.
			generate_pot_as()


func _show_work_screen() -> void:
	start_screen.hide()
	work_screen.show()


func _show_start_screen() -> void:
	start_screen.show()
	work_screen.hide()


func _set_story_editor() -> void:
	story_editor.load_story(story)


func _set_episode_editor() -> void:
	episode_editor.load_story(story)


func _set_character_editor() -> void:
	character_editor.load_story(story)


func _set_location_editor() -> void:
	location_editor.load_story(story)


func _set_visual_effect_editor() -> void:
	visual_effect_editor.load_story(story)


func _set_sound_effect_editor() -> void:
	sound_effect_editor.load_story(story)


func _set_music_editor() -> void:
	music_editor.load_story(story)


func _set_transitition_editor() -> void:
	transitition_editor.load_story(story)


func _set_scene_editor() -> void:
	scene_editor.load_story(story)


func create_story() -> void:
	create_file_dialog.show()


func _create_story_by_path(path: String) -> void:
	story = RSEStory.new(path)


func load_story() -> void:
	#save_story()
	open_file_dialog.show()


func _load_story_by_path(path: String) -> void:
	save_story()
	story = RSEStory.load_from_file(path)


func save_story() -> void:
	if story != null:
		story.graph_state = story_editor.get_graph_state()
		episode_editor.save_episode()
		story.save_to_file()


func save_as_story() -> void:
	save_file_dialog.show()


func _save_as_story_by_path(path: String) -> void:
	if story != null:
		story._path_to_story_file = path
		save_story()


func generate_pot_as() -> void:
	save_pot_dialog.show()


func _on_save_pot_dialog_file_selected(path):
	if story != null:
		generate_pot(path)


func change_mode(mode: Mode):
	match current_mode:
		Mode.History:
			story.graph_state = story_editor.get_graph_state()
		Mode.Episode:
			episode_editor.save_episode()
	
	match mode:
		Mode.History:
			story_editor.load_story(story)
		Mode.Episode:
			episode_editor.update_item_list()
			episode_editor.update_current_episode()
		Mode.Character:
			character_editor.update_item_list()
		Mode.Location:
			location_editor.update_item_list()
		Mode.VisualEffect:
			visual_effect_editor.update_item_list()
		Mode.SoundEffect:
			sound_effect_editor.update_item_list()
		Mode.Music:
			music_editor.update_item_list()
		Mode.Transitition:
			transitition_editor.update_item_list()
		Mode.Scene:
			scene_editor.update_item_list()
	
	current_mode = mode


func open_episode(episode: RSEEpisode) -> void:
	if current_mode == Mode.Episode:
		return
	episode_editor.episode = episode
	await get_tree().create_timer(0.02).timeout
	tab_container.current_tab = Mode.Episode


func generate_pot(path: String) -> void:
	var pot: String = 'msgid ""\nmsgstr ""\n\n'
	
	pot += get_pot_string(story.name)
	
	for character: RSECharacter in story.characters.values():
		pot += get_pot_string(character.name)
		pot += get_pot_string(character.display_name)
	
	#for location: RSELocation in story.locations.values():
		#pot += get_pot_string(location.name)
		
	var keys: PackedStringArray = []
	
	for episode: RSEEpisode in story.episodes.values():
		pot += get_pot_string(episode.name)
		for frame: RSEFrame in episode.frames:
			if frame is RSEFrameText:
				if not keys.has(frame.text):
					keys.append(frame.text)
					pot += get_pot_string(frame.text)
	
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(pot)
	file.close()


func get_pot_string(text: String) -> String:
	return 'msgid "%s"\nmsgstr "%s"\n\n' % [text, text] 
