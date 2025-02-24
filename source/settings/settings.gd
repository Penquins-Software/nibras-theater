extends Node

signal locale_was_changed
signal player_name_was_changed

const PATH_TO_CONFIG = "user://config.ini"
const PATH_TO_PROFILE = "user://profile.json"
const PATH_TO_STORY = "res://project_rice.rs"

enum AudioBus {
	MASTER,
	SFX,
	MUSIC,
	BLEEP,
}

## Режимы пропуска кадров.
enum RewindMode {
	Viewed = 0, ## Только просмотренное.
	Full = 1, ## Перематывать всё.
	Mega = 666, ## Секретный режим.
}

var audio_bus_name: Dictionary = {
	AudioBus.MASTER : &"Master",
	AudioBus.SFX : &"SFX",
	AudioBus.MUSIC : &"Music",
	AudioBus.BLEEP : &"Bleep",
}

var config: ConfigFile

var profile: Profile

var player_name: String = "" : set = _set_player_name
var locale: String = OS.get_locale() : set = _set_locale
var screen_mode: DisplayServer.WindowMode = DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN : set = _set_screen_mode

var master_volume: int = 50 : set = _set_master_volume
var sfx_volume: int = 50 : set = _set_sfx_volume
var music_volume: int = 50 : set = _set_music_volume

var bleep_mode: bool = true : set = _set_bleep_mode

var rewind_mode: RewindMode = RewindMode.Viewed : set = _set_rewind_mode

var last_save: String

## Скорость вывода текста. Измеряется в количестве символов в секунду.
var text_speed: int = 40 : set = _set_text_speed
const MIN_TEXT_SPEED: int = 20
const MAX_TEXT_SPEED: int = 80

## Скорость автоматического переключения кадров. Измеряется в символах на секунду после показа текста.
var auto_speed: int = 20 : set = _set_auto_speed
const MIN_AUTO_SPEED: int = 10
const MAX_AUTO_SPEED: int = 60

var loading_locations_thread: Thread
var loading_characters_thread: Thread


func _set_player_name(new_name: String) -> void:
	player_name = new_name
	player_name_was_changed.emit()
	print("Player name: %s" % player_name);


func _set_locale(new_locale: String) -> void:
	if new_locale.begins_with("ru"):
		new_locale = "ru"
	else:
		new_locale = "en"
	locale = new_locale
	TranslationServer.set_locale(locale)
	locale_was_changed.emit()
	print("Locale: %s" % locale);


func _set_screen_mode(mode: DisplayServer.WindowMode) -> void:
	screen_mode = mode
	DisplayServer.window_set_mode(screen_mode)
	print("Screen mode: %s" % screen_mode);


func _set_master_volume(value: int) -> void:
	master_volume = value
	var db: float = linear_to_db(value / 100.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(audio_bus_name[AudioBus.MASTER]), db)
	print("%s bus volume is set to %s db." % [audio_bus_name[AudioBus.MASTER], db]);


func _set_sfx_volume(value: int) -> void:
	sfx_volume = value
	var db: float = linear_to_db(value / 100.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(audio_bus_name[AudioBus.SFX]), db)
	print("%s bus volume is set to %s db." % [audio_bus_name[AudioBus.SFX], db]);


func _set_music_volume(value: int) -> void:
	music_volume = value
	var db: float = linear_to_db(value / 100.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(audio_bus_name[AudioBus.MUSIC]), db)
	print("%s bus volume is set to %s db." % [audio_bus_name[AudioBus.MUSIC], db]);


func _set_rewind_mode(mode: RewindMode) -> void:
	rewind_mode = mode
	print("Rewind mode: %s." % RewindMode.keys()[rewind_mode]);


func _set_text_speed(value: int) -> void:
	if value < MIN_TEXT_SPEED:
		value = MIN_TEXT_SPEED
	elif value > MAX_TEXT_SPEED:
		value = MAX_TEXT_SPEED

	text_speed = value
	print("Text speed: %s." % text_speed);


func _set_auto_speed(value: int) -> void:
	if value < MIN_AUTO_SPEED:
		value = MIN_AUTO_SPEED
	elif value > MAX_AUTO_SPEED:
		value = MAX_AUTO_SPEED

	auto_speed = value
	print("Auto speed: %s." % auto_speed);


func _set_bleep_mode(status: bool) -> void:
	bleep_mode = status
	AudioServer.set_bus_mute(AudioServer.get_bus_index(audio_bus_name[AudioBus.BLEEP]), not status)
	print("Bleep mode: %s" % status)


func _enter_tree():
	load_config()
	profile = Profile.load_from_file(PATH_TO_PROFILE)
	RewindStoryEngine.story = RSEStory.load_from_file(PATH_TO_STORY)
	load_locations()
	load_characters()


func load_locations() -> void:
	loading_locations_thread = Thread.new()
	loading_locations_thread.start(RSESceneBuilder.load_all_locations)


func load_characters() -> void:
	loading_characters_thread = Thread.new()
	loading_characters_thread.start(RSESceneBuilder.load_all_characters)


func close_threads() -> void:
	loading_locations_thread.wait_to_finish()
	loading_characters_thread.wait_to_finish()


func _exit_tree():
	close_threads()
	save_config()
	profile.save_to_file(PATH_TO_PROFILE)


func save_config() -> void:
	print("Saving settings.")
	if config == null:
		config = ConfigFile.new()
	
	config.set_value("profile", "player_name", player_name)
	
	config.set_value("general_settings", "locale", locale)
	
	config.set_value("screen_settings", "mode", int(screen_mode))
	config.set_value("screen_settings", "screen_size", get_window().size)
	
	config.set_value("audio_settings", "master_volume", master_volume)
	config.set_value("audio_settings", "sfx_volume", sfx_volume)
	config.set_value("audio_settings", "music_volume", music_volume)
	
	config.set_value("game_settings", "rewind_mode", rewind_mode)
	config.set_value("game_settings", "text_speed", text_speed)
	config.set_value("game_settings", "bleep_mode", bleep_mode)
	
	config.set_value("game_settings", "last_save", last_save)
	
	config.save(PATH_TO_CONFIG)


func load_config() -> void:
	print("Loading settings.")
	if config == null:
		config = ConfigFile.new()
	
	var error = config.load(PATH_TO_CONFIG)
	if error == OK:
		player_name = config.get_value("profile", "player_name", "")
		
		locale = config.get_value("general_settings", "locale", "en")
		
		screen_mode = config.get_value("screen_settings", "mode", DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	
		get_window().size = config.get_value("screen_settings", "screen_size", Vector2(1280, 720))
		get_window().move_to_center()
		
		master_volume = config.get_value("audio_settings", "master_volume", 50)
		sfx_volume = config.get_value("audio_settings", "sfx_volume", 50)
		music_volume = config.get_value("audio_settings", "music_volume", 50)
	
		rewind_mode = config.get_value("game_settings", "rewind_mode", RewindMode.Viewed)
		text_speed = config.get_value("game_settings", "text_speed", 40)
		bleep_mode = config.get_value("game_settings", "bleep_mode", true)
		
		last_save = config.get_value("game_settings", "last_save", "")
		
		print("Configuration file loaded successfully!")
	else:
		print("Failed to read configuration file: %s" % error)
		locale = OS.get_locale()


func set_audio_volume(bus: AudioBus, value: int) -> void:
	match bus:
		AudioBus.MASTER:
			master_volume = value
		AudioBus.SFX:
			sfx_volume = value
		AudioBus.MUSIC:
			music_volume = value


func get_audio_volume(bus: AudioBus) -> int:
	match bus:
		AudioBus.MASTER:
			return master_volume
		AudioBus.SFX:
			return sfx_volume
		AudioBus.MUSIC:
			return music_volume
		_:
			return 0
