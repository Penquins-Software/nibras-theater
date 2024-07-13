class_name RSESoundEffect
extends RefCounted


var id: int
var name: String
var once_playable: bool = true
var path_to_file: String
var active: bool = false


func _init(id: int):
	self.id = id


func save_to_dictionary() -> Dictionary:
	var data := {
		"id" : id,
		"name" : name,
		"once_playable" : once_playable,
		"path_to_file" : path_to_file,
		"active" : active,
	}
	
	return data


static func load_from_dictionary(data: Dictionary) -> RSESoundEffect:
	var sound_effect = RSESoundEffect.new(data["id"])
	
	sound_effect.name = data["name"]
	sound_effect.once_playable = data["once_playable"]
	sound_effect.path_to_file = data["path_to_file"]
	sound_effect.active = data["active"]
	
	return sound_effect


func get_id_with_name() -> String:
	var name = self.name
	if name == "":
		name = "[Без названия]"
	return "%s: %s" % [id, name]
