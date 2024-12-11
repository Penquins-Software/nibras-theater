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
var path_to_bleep_sound: String


func _set_name(new_name: String) -> void:
	name = new_name
	if main_name_for_display_name:
		display_name = name


func set_main_name_for_display_name(status: bool) -> void:
	main_name_for_display_name = status
	if status:
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
		"path_to_bleep_sound" : path_to_bleep_sound,
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
	character.path_to_bleep_sound = data["path_to_bleep_sound"]
	
	return character


func get_id_with_name() -> String:
	var name = self.name
	if name == "":
		name = "[Без названия]"
	return "%s: %s" % [id, name]


func add_emotion() -> int:
	#var emotion_id = int(emotions.keys()[emotions.size() - 1]) + 1
	var emotion_id = _get_next_id(emotions)
	emotions[str(emotion_id)] = ""
	return emotion_id


func add_outfit() -> int:
	var outfit_id = int(outfits.keys()[outfits.size() - 1]) + 1
	outfits[str(outfit_id)] = ""
	return outfit_id


func _get_next_id(dict: Dictionary) -> int:
	var max_id: int = 0
	for id in dict.keys():
		if int(id) > max_id:
			max_id = int(id)
	return max_id + 1


static func get_skeaker_name(speaker: RSECharacter, episode: RSEEpisode, current_frame_index: int) -> String:
	match episode.id:
		## Театр Нибраса. Эпизод "Репетиция". Весь эпизод неизвестно имя актёров и бутафора.
		24:
			if speaker.id == 13 or speaker.id == 19 or speaker.id == 40:
				return "Актриса"
			if speaker.id == 25:
				return "Актёр"
			if speaker.id == 39:
				return "Бутафор"
		## Театр Нибраса. Эпизод "После репетиции".
		42:
			if speaker.id == 13 or speaker.id == 19:
				return "Актриса"
			if speaker.id == 25:
				return "Актёр"
			if speaker.id == 39 and current_frame_index < 14:
				return "Бутафор"
		## Нибрас Театра. Часть 1. Весь эпизод неизвестно имя актёров и бутафора.
		160:
			if speaker.id == 13 or speaker.id == 19 or speaker.id == 40:
				return "Актриса"
			if speaker.id == 25:
				return "Актёр"
			if speaker.id == 39:
				return "Бутафор"
		## Нибрас Театра. Часть 2. До определённого момента неизвестны имена актёров и бутафора.
		161:
			if (speaker.id == 13 or speaker.id == 19) and current_frame_index < 163:
				return "Актриса"
			if speaker.id == 25 and current_frame_index < 163:
				return "Актёр"
			if speaker.id == 39 and current_frame_index < 89:
				return "Бутафор"
	
	return speaker.display_name
