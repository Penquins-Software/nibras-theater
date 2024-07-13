class_name RSEFrameCharacter
extends RSEFrame


var character_id: int = 0
var action: RSECharacter.Action = RSECharacter.Action.None
var emotion_id: int = 0
var outfit_id: int = 0


func write_frame_info_to_scene_state(scene_state: RSESceneState) -> void:
	match action:
		RSECharacter.Action.Join:
			if not scene_state.characters.has(character_id):
				scene_state.characters[character_id] = {
					"emotion_id": emotion_id,
					"outfit_id": outfit_id,
				}
		RSECharacter.Action.Leave:
			if scene_state.characters.has(character_id):
				scene_state.characters.erase(character_id)
		RSECharacter.Action.Emotion:
			scene_state.characters[character_id]["emotion_id"] = emotion_id
		RSECharacter.Action.Outfit:
			scene_state.characters[character_id]["outfit_id"] = outfit_id


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Character


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameCharacter",
		"character_id" : character_id,
		"action" : action,
		"emotion_id" : emotion_id,
		"outfit_id" : outfit_id,
	}


func print_info() -> void:
	print("character_id : %s| action : %s| emotion_id : %s| outfit_id : %s|" % [character_id, action, emotion_id, outfit_id])
