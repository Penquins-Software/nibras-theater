class_name RSEVisualEffect
extends RefCounted


var id: int
var name: String
var path_to_scene: String
var active: bool = false


func _init(id: int):
	self.id = id


func save_to_dictionary() -> Dictionary:
	var data := {
		"id" : id,
		"name" : name,
		"path_to_scene" : path_to_scene,
		"active" : active,
	}
	
	return data


static func load_from_dictionary(data: Dictionary) -> RSEVisualEffect:
	var visual_effect = RSEVisualEffect.new(data["id"])
	
	visual_effect.name = data["name"]
	visual_effect.path_to_scene = data["path_to_scene"]
	visual_effect.active = data["active"]
	
	return visual_effect


func get_id_with_name() -> String:
	var name = self.name
	if name == "":
		name = "[Без названия]"
	return "%s: %s" % [id, name]
