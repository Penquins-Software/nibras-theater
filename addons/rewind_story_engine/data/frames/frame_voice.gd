class_name RSEFrameVoice
extends RSEFrame


var path_to_audio: String


func write_frame_info_to_scene_state(scene_state: RSESceneState) -> void:
	scene_state.voice = path_to_audio


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Voice


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameVoice",
		"path_to_audio" : path_to_audio,
	}
