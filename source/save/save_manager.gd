extends Node


signal saves_loaded()

const PATH_TO_SAVE_FOLDER = "user://saves"
const PATH_TO_AUTOSAVE = "user://saves/autosave"

var saves: Array[Save]


func _enter_tree():
	get_saves()


func create_save(image: Image, episode_id: int, frame_index: int, local_variables: Dictionary) -> void:
	if not DirAccess.dir_exists_absolute(PATH_TO_SAVE_FOLDER):
		DirAccess.make_dir_absolute(PATH_TO_SAVE_FOLDER)
	
	var save = Save.new(image, episode_id, frame_index, local_variables)
	var file_name = PATH_TO_SAVE_FOLDER + "/" + save.get_file_name()
	save.save_to_file(file_name)
	
	get_saves()


func get_saves() -> void:
	saves.clear()
	var dir = DirAccess.open(PATH_TO_SAVE_FOLDER)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and not file_name.ends_with(".png"):
				var full_path = PATH_TO_SAVE_FOLDER + "/" + file_name
				var save = Save.load_from_file(full_path)
				saves.append(save)
				if full_path == PATH_TO_AUTOSAVE:
					save.auto_save = true
			file_name = dir.get_next()
	saves_loaded.emit()


func create_autosave(image: Image, episode_id: int, frame_index: int, local_variables: Dictionary) -> void:
	if not DirAccess.dir_exists_absolute(PATH_TO_SAVE_FOLDER):
		DirAccess.make_dir_absolute(PATH_TO_SAVE_FOLDER)
	
	var save = Save.new(image, episode_id, frame_index, local_variables)
	save.save_to_file(PATH_TO_AUTOSAVE)
	
	get_saves()
