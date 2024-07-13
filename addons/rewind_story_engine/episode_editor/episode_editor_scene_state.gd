class_name EpisodeEditorSceneState
extends RefCounted


var location_id: int
var characters: Dictionary
var variables: Dictionary
var visual_effect_ids: Array[int]
var sound_effect_ids: Array[int]
var music_id: int
var voice: String


func clear() -> void:
	location_id = -1
	characters.clear()
	visual_effect_ids.clear()
	sound_effect_ids.clear()
	music_id = -1
	voice = ""
