class_name RSEFrameComment
extends RSEFrame


var text: String


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Comment


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameComment",
		"text" : text,
	}
