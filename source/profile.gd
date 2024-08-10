class_name Profile
extends RefCounted


var global_variables: VariablesStorage = VariablesStorage.new()
## Просмотренные эпизоды и кадры.
var viewed: Dictionary


func add_viewed(episode_id: int, frame_index: int) -> void:
	if not viewed.has(str(episode_id)):
		viewed[str(episode_id)] = []
	
	if not viewed[str(episode_id)].has(float(frame_index)):
		viewed[str(episode_id)].append(float(frame_index))


func is_viewed(episode_id: int, frame_index: int) -> bool:
	if not viewed.has(str(episode_id)):
		return false
	
	if not viewed[str(episode_id)].has(float(frame_index)):
		return false
	
	return true


func save_to_file(path_to_file: String) -> void:
	var data := {
		"global_variables" : global_variables.data,
		"viewed" : viewed,
	}
	
	var json_string = JSON.stringify(data, " ")
	
	var file = FileAccess.open(path_to_file, FileAccess.WRITE)
	file.store_string(json_string)
	file.close()


static func load_from_file(path_to_file: String) -> Profile:
	var profile = Profile.new()
	
	var file = FileAccess.open(path_to_file, FileAccess.READ)
	if file == null:
		return profile
	
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		profile.global_variables.data = json.data["global_variables"]
		profile.viewed = json.data["viewed"]
	
	print("Profile has been loaded.")
	if Engine.is_editor_hint():
		print("Global variables: %s" % profile.global_variables.data)
		print("Viewed: %s" % profile.viewed)
	return profile
