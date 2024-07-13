class_name RSETransitition
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


static func load_from_dictionary(data: Dictionary) -> RSETransitition:
	var transitition = RSETransitition.new(data["id"])
	
	transitition.name = data["name"]
	transitition.path_to_scene = data["path_to_scene"]
	transitition.active = data["active"]
	
	return transitition


func get_id_with_name() -> String:
	var name = self.name
	if name == "":
		name = "[Без названия]"
	return "%s: %s" % [id, name]
