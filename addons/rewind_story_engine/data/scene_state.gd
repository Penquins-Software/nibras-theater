class_name RSESceneState
extends RefCounted


var location_id: int
var characters: Dictionary
var variables: Dictionary
var visual_effect_ids: Array[int]
var sound_effect_ids: Array[int]
var music_id: int
var voice: String
var speaker_id: int
var text: String
var gap: bool = false


func clear() -> void:
	location_id = -1
	characters.clear()
	visual_effect_ids.clear()
	sound_effect_ids.clear()
	music_id = -1
	voice = ""
	speaker_id = -1
	text = ""
	gap = false


func make_copy() -> RSESceneState:
	var copy = RSESceneState.new()
	
	copy.location_id = location_id
	copy.characters = characters.duplicate(true)
	copy.variables = variables.duplicate(true)
	copy.visual_effect_ids = visual_effect_ids.duplicate(true)
	copy.sound_effect_ids = sound_effect_ids.duplicate(true)
	copy.music_id = music_id
	copy.voice = voice
	copy.speaker_id = speaker_id
	copy.text = text
	copy.gap = gap
	
	return copy


func print_info() -> void:
	print("--------------------")
	print("location_id: %s" % location_id)
	print("characters: %s" % characters)
	if visual_effect_ids.size() > 0:
		print("visual_effect_ids: %s" % visual_effect_ids)
	print("--------------------")
