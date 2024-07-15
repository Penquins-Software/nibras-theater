class_name RSEStory
extends RefCounted


var _path_to_story_file: String

var name: String
var episodes: Dictionary
var characters: Dictionary
var locations: Dictionary
var visual_effects: Dictionary
var sound_effects: Dictionary
var music_list: Dictionary
var transititions: Dictionary

var graph_state: Dictionary

var last_id: int = 0

var start_episode: RSEEpisode

var max_symbols_in_text_box: int = 200


func _init(path_to_story_file: String):
	_path_to_story_file = path_to_story_file


func save_to_file() -> void:
	var data := {
		"name" : name,
		"last_id" : last_id,
		"graph_state" : graph_state,
	}
	
	var episode_info_array = []
	for id in episodes:
		episode_info_array.append(episodes[id].save_to_dictionary())
	data["episodes"] = episode_info_array
	
	var character_info_array = []
	for id in characters:
		character_info_array.append(characters[id].save_to_dictionary())
	data["characters"] = character_info_array
	
	var location_info_array = []
	for id in locations:
		location_info_array.append(locations[id].save_to_dictionary())
	data["locations"] = location_info_array
	
	var visual_effect_info_array = []
	for id in visual_effects:
		visual_effect_info_array.append(visual_effects[id].save_to_dictionary())
	data["visual_effects"] = visual_effect_info_array
	
	var sound_effect_info_array = []
	for id in sound_effects:
		sound_effect_info_array.append(sound_effects[id].save_to_dictionary())
	data["sound_effects"] = sound_effect_info_array
	
	var music_info_array = []
	for id in music_list:
		music_info_array.append(music_list[id].save_to_dictionary())
	data["music_list"] = music_info_array
	
	var transitition_info_array = []
	for id in transititions:
		transitition_info_array.append(transititions[id].save_to_dictionary())
	data["transititions"] = transitition_info_array
	
	var json_string = JSON.stringify(data, " ")
	
	var file = FileAccess.open(_path_to_story_file, FileAccess.WRITE)
	file.store_string(json_string)
	file.close()


static func load_from_file(path_to_file: String) -> RSEStory:
	print("Загрузка истории: " + path_to_file)
	var story = RSEStory.new(path_to_file)
	
	var file = FileAccess.open(story._path_to_story_file, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		story.name = json.data["name"]
		story.last_id = json.data["last_id"]
		story.graph_state = json.data["graph_state"]
		
		if json.data.has("episodes"):
			for episode_info in json.data["episodes"]:
				var episode = RSEEpisode.load_from_dictionary(story, episode_info)
				story.episodes[episode.id] = episode
		
		if json.data.has("characters"):
			for character_info in json.data["characters"]:
				var character = RSECharacter.load_from_dictionary(character_info)
				story.characters[character.id] = character
		
		if json.data.has("locations"):
			for location_info in json.data["locations"]:
				var location = RSELocation.load_from_dictionary(location_info)
				story.locations[location.id] = location
		
		if json.data.has("visual_effects"):
			for visual_effect_info in json.data["visual_effects"]:
				var visual_effect = RSEVisualEffect.load_from_dictionary(visual_effect_info)
				story.visual_effects[visual_effect.id] = visual_effect
		
		if json.data.has("sound_effects"):
			for sound_effect_info in json.data["sound_effects"]:
				var sound_effect = RSESoundEffect.load_from_dictionary(sound_effect_info)
				story.sound_effects[sound_effect.id] = sound_effect
		
		if json.data.has("music_list"):
			for music_info in json.data["music_list"]:
				var music = RSEMusic.load_from_dictionary(music_info)
				story.music_list[music.id] = music
		
		if json.data.has("transititions"):
			for transitition_info in json.data["transititions"]:
				var transitition = RSETransitition.load_from_dictionary(transitition_info)
				story.transititions[transitition.id] = transitition
	
	return story


func get_new_id() -> int:
	last_id += 1
	return last_id


func add_episode() -> RSEEpisode:
	var episode = RSEEpisode.new(self, get_new_id())
	episodes[episode.id] = episode
	return episode


func add_character() -> RSECharacter:
	var character = RSECharacter.new(get_new_id())
	character.emotions = {
		"0" : "Normal",
	}
	character.outfits = {
		"0" : "Default",
	}
	characters[character.id] = character
	return character


func add_location() -> RSELocation:
	var location = RSELocation.new(get_new_id())
	locations[location.id] = location
	return location


func add_visual_effect() -> RSEVisualEffect:
	var visual_effect = RSEVisualEffect.new(get_new_id())
	visual_effects[visual_effect.id] = visual_effect
	return visual_effect


func add_sound_effect() -> RSESoundEffect:
	var sound_effect = RSESoundEffect.new(get_new_id())
	sound_effects[sound_effect.id] = sound_effect
	return sound_effect


func add_music() -> RSEMusic:
	var music = RSEMusic.new(get_new_id())
	music_list[music.id] = music
	return music


func add_transitition() -> RSETransitition:
	var transitition = RSETransitition.new(get_new_id())
	transititions[transitition.id] = transitition
	return transitition
