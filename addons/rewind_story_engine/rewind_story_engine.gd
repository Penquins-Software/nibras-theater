@tool
extends EditorPlugin

const PathToPluginFolder = "user://rse"
const PathToPluginSettings = "user://rse/settings.json"

const PathToGameHandler = "res://addons/rewind_story_engine/rse_handler.gd"
const MainPanel = preload("res://addons/rewind_story_engine/rewind_story_engine.tscn")


var path_to_story_file = ""

var plugin_controller: RSEPluginController


func _enter_tree():
	plugin_controller = MainPanel.instantiate()
	EditorInterface.get_editor_main_screen().add_child(plugin_controller)
	_make_visible(false)
	
	if not ProjectSettings.has_setting("autoload/RewindStoryEngine"):
		add_autoload_singleton("RewindStoryEngine", PathToGameHandler)
	
	_load_settings()


func _exit_tree():
	_save_settings()
	
	if plugin_controller:
		plugin_controller.scene_editor.scene_builder.save_scene_preset()
		plugin_controller.save_story()
		plugin_controller.queue_free()


func _has_main_screen():
	return true


func _make_visible(visible):
	if plugin_controller:
		plugin_controller.visible = visible


func _get_plugin_name():
	return "Rewind Story Engine"


func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")


func _load_settings() -> void:
	if not DirAccess.dir_exists_absolute(PathToPluginFolder):
		return
	
	var file = FileAccess.open(PathToPluginSettings, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		path_to_story_file = json.data["path_to_last_story_file"]
		if path_to_story_file != "":
			_load_last_story()


func _save_settings() -> void:
	if plugin_controller.story == null:
		return
	
	if not DirAccess.dir_exists_absolute(PathToPluginFolder):
		DirAccess.make_dir_absolute(PathToPluginFolder)
	
	var data = {
		"path_to_last_story_file" : plugin_controller.story._path_to_story_file,
	}
	var json_string = JSON.stringify(data, " ")
	
	var file = FileAccess.open(PathToPluginSettings, FileAccess.WRITE)
	file.store_string(json_string)
	file.close()


func _load_last_story() -> void:
	if plugin_controller != null:
		plugin_controller.story = RSEStory.load_from_file(path_to_story_file)
