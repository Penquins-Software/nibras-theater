class_name RSEFrameEndCondition
extends RSEFrame


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.EndCondition


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameEndCondition",
	}
