class_name RSEFrameEndCondition
extends RSEFrame


var condition: RSEFrameCondition


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.EndCondition


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameEndCondition",
	}
