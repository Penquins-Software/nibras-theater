class_name RSEMusic
extends RefCounted


var id: int
var name: String
var path_to_file: String
var active: bool = false


func _init(id: int):
	self.id = id


func save_to_dictionary() -> Dictionary:
	var data := {
		"id" : id,
		"name" : name,
		"path_to_file" : path_to_file,
		"active" : active,
	}
	
	return data


static func load_from_dictionary(data: Dictionary) -> RSEMusic:
	var music = RSEMusic.new(data["id"])
	
	music.name = data["name"]
	music.path_to_file = data["path_to_file"]
	music.active = data["active"]
	
	return music


func get_id_with_name() -> String:
	var name = self.name
	if name == "":
		name = "[Без названия]"
	return "%s: %s" % [id, name]
