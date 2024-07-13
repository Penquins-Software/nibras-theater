class_name RSEFrameVariable
extends RSEFrame


var name: String = ""
var value


func write_frame_info_to_scene_state(scene_state: RSESceneState) -> void:
	scene_state.variables[name] = value


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Variable


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameVariable",
		"name" : name,
		"value" : value,
	}
