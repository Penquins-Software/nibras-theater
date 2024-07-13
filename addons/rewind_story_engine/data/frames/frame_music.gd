class_name RSEFrameMusic
extends RSEFrame


var music_id: int = 0


func write_frame_info_to_scene_state(scene_state: RSESceneState) -> void:
	scene_state.music_id = music_id


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Music


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameMusic",
		"music_id" : music_id,
	}
