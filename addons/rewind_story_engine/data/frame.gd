class_name RSEFrame
extends RefCounted


enum FrameType {
	None,
	Character,
	Comment,
	Condition,
	EraseScene,
	Jump,
	Location,
	Music,
	Selection,
	SignalFrame,
	SoundEffect,
	Text,
	Variable,
	VisualEffect,
	Voice,
	Gap,
	EndCondition,
}


var scene_state: RSESceneState

## Кадр, на котором нужно остановится.
var real_frame: bool = false


func write_frame_info_to_scene_state(scene_state: RSESceneState) -> void:
	pass


func get_frame_type() -> FrameType:
	return FrameType.None


func save_frame_to_dictionary() -> Dictionary:
	return {}


static func load_frame_from_dictionary(data: Dictionary) -> RSEFrame:
	match data["type"]:
		"RSEFrameCharacter":
			var frame = RSEFrameCharacter.new()
			frame.character_id = data["character_id"]
			frame.action = data["action"]
			frame.emotion_id = data["emotion_id"]
			frame.outfit_id = data["outfit_id"]
			return frame
		"RSEFrameComment":
			var frame = RSEFrameComment.new()
			frame.text = data["text"]
			return frame
		"RSEFrameCondition":
			var frame = RSEFrameCondition.new()
			frame.condition = data["condition"]
			frame.global = data["global"]
			return frame
		"RSEFrameEraseScene":
			var frame = RSEFrameEraseScene.new()
			return frame
		"RSEFrameJump":
			var frame = RSEFrameJump.new()
			frame.to_episode_id = data["to_episode_id"]
			frame.description = data["description"]
			return frame
		"RSEFrameLocation":
			var frame = RSEFrameLocation.new()
			frame.location_id = data["location_id"]
			frame.transitition_id = data["transitition_id"]
			return frame
		"RSEFrameMusic":
			var frame = RSEFrameMusic.new()
			frame.music_id = data["music_id"]
			return frame
		"RSEFrameSelection":
			var frame = RSEFrameSelection.new()
			frame.options = data["options"]
			return frame
		"RSEFrameSignal":
			var frame = RSEFrameSignal.new()
			frame.text_signal = data["text_signal"]
			return frame
		"RSEFrameSoundEffect":
			var frame = RSEFrameSoundEffect.new()
			frame.sound_id = data["sound_id"]
			frame.status = data["status"]
			return frame
		"RSEFrameText":
			var frame = RSEFrameText.new()
			frame.speaker_id = data["speaker_id"]
			frame.text = data["text"]
			return frame
		"RSEFrameVariable":
			var frame = RSEFrameVariable.new()
			frame.name = data["name"]
			frame.value = data["value"]
			frame.global = data["global"]
			return frame
		"RSEFrameVisualEffect":
			var frame = RSEFrameVisualEffect.new()
			frame.effect_id = data["effect_id"]
			frame.status = data["status"]
			return frame
		"RSEFrameVoice":
			var frame = RSEFrameVoice.new()
			frame.path_to_audio = data["path_to_audio"]
			return frame
		"RSEFrameGap":
			var frame = RSEFrameGap.new()
			return frame
		"RSEFrameEndCondition":
			var frame = RSEFrameEndCondition.new()
			return frame
	return null


func print_info() -> void:
	return
