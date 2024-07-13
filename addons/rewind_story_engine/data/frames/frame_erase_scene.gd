class_name RSEFrameEraseScene
extends RSEFrame


func write_frame_info_to_scene_state(scene_state: RSESceneState) -> void:
	scene_state.clear()


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.EraseScene


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameEraseScene",
	}
