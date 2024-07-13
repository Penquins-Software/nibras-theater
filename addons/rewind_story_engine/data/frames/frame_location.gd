class_name RSEFrameLocation
extends RSEFrame


var location_id: int = 0
var transitition_id: int = 0


func write_frame_info_to_scene_state(scene_state: RSESceneState) -> void:
	scene_state.location_id = location_id


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Location


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameLocation",
		"location_id" : location_id,
		"transitition_id" : transitition_id,
	}
