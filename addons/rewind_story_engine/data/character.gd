class_name RSECharacter
extends RefCounted


enum Action
{
	None,
	Join,
	Leave,
	Emotion,
	Outfit,
}


var id: int
var name: String : set = _set_name
var display_name: String
var main_name_for_display_name: bool = true
var description: String
var path_to_scene: String
var active: bool = false
var color: Color = Color.GRAY
var emotions: Dictionary
var outfits: Dictionary


func _set_name(new_name: String) -> void:
	name = new_name
	if main_name_for_display_name:
		display_name = name


func _init(id: int):
	self.id = id


func save_to_dictionary() -> Dictionary:
	var data := {
		"id" : id,
		"name" : name,
		"display_name" : display_name,
		"main_name_for_display_name" : main_name_for_display_name,
		"description" : description,
		"path_to_scene" : path_to_scene,
		"active" : active,
		"color_a" : color.a,
		"color_r" : color.r,
		"color_g" : color.g,
		"color_b" : color.b,
		"emotions" : emotions,
		"outfits" : outfits,
	}
	
	return data


static func load_from_dictionary(data: Dictionary) -> RSECharacter:
	var character = RSECharacter.new(data["id"])
	
	character.name = data["name"]
	character.display_name = data["display_name"]
	character.main_name_for_display_name = data["main_name_for_display_name"]
	character.description = data["description"]
	character.path_to_scene = data["path_to_scene"]
	character.active = data["active"]
	character.color.a = data["color_a"]
	character.color.r = data["color_r"]
	character.color.g = data["color_g"]
	character.color.b = data["color_b"]
	character.emotions = data["emotions"]
	character.outfits = data["outfits"]
	
	return character


func get_id_with_name() -> String:
	var name = self.name
	if name == "":
		name = "[Без названия]"
	return "%s: %s" % [id, name]


func add_emotion() -> int:
	var emotion_id = int(emotions.keys()[emotions.size() - 1]) + 1
	emotions[str(emotion_id)] = ""
	return emotion_id


func add_outfit() -> int:
	var outfit_id = int(outfits.keys()[outfits.size() - 1]) + 1
	outfits[str(outfit_id)] = ""
	return outfit_id
