class_name Save
extends RefCounted


var image: Image
var episode_id: int
var episode_name: String
var frame_index: int
var local_variables: Dictionary
var datetime: Dictionary
var path: String
var auto_save: bool = false


func _init(_image: Image, _episode_id: int, _frame_index: int, _local_variables: Dictionary, path_to_file: String = ""):
	image = _image
	episode_id = _episode_id
	episode_name = RewindStoryEngine.story.episodes[episode_id].name
	frame_index = _frame_index
	local_variables = _local_variables
	path = path_to_file
	datetime = Time.get_datetime_dict_from_system()


func get_file_name() -> String:
	var file_name: String = "%s%s%s" % [datetime["year"], datetime["month"], datetime["day"]]
	file_name += "%s%s%s" % [datetime["hour"], datetime["minute"], datetime["second"]]
	return file_name


func save_to_file(path_to_file: String) -> void:
	Settings.last_save = path_to_file
	
	var data := {
		"episode_id" : episode_id,
		"episode_name" : episode_name,
		"frame_index" : frame_index,
		"local_variables" : local_variables,
		"datetime" : datetime,
	}
	
	var json_string = JSON.stringify(data, " ")
	
	var file = FileAccess.open(path_to_file, FileAccess.WRITE)
	file.store_string(json_string)
	file.close()
	
	if image != null:
		image.save_jpg(path_to_file + ".jpg")


static func load_from_file(path_to_file: String) -> Save:
	var file = FileAccess.open(path_to_file, FileAccess.READ)
	if file == null:
		return null
	
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var error = json.parse(json_string)
	
	var _image: Image = Image.new()
	var _episode_id: int
	var _episode_name: String
	var _frame_index: int
	var _local_variables: Dictionary
	var _datetime: Dictionary
	
	if error == OK:
		_episode_id = json.data["episode_id"]
		_episode_name = json.data["episode_name"]
		_frame_index = json.data["frame_index"]
		_local_variables = json.data["local_variables"]
		_datetime = json.data["datetime"]
	
	var path_to_image = path_to_file + ".jpg"
	if FileAccess.file_exists(path_to_image):
		_image = Image.load_from_file(path_to_image)
	
	var save = Save.new(_image, _episode_id, _frame_index, _local_variables, path_to_file)
	save.datetime = _datetime
	return save


func delete() -> void:
	DirAccess.remove_absolute(path)
	DirAccess.remove_absolute(path + ".jpg")
	SaveManager.get_saves()
