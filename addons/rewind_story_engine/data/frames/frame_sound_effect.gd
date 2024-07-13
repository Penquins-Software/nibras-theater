class_name RSEFrameSoundEffect
extends RSEFrame


var sound_id: int = 0
var status: bool = false


func write_frame_info_to_scene_state(scene_state: RSESceneState) -> void:
	if status:
		if not scene_state.sound_effect_ids.has(sound_id):
			scene_state.sound_effect_ids.append(sound_id)
	else:
		if scene_state.sound_effect_ids.has(sound_id):
			scene_state.sound_effect_ids.erase(sound_id)


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.SoundEffect


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameSoundEffect",
		"sound_id" : sound_id,
		"status" : status,
	}
