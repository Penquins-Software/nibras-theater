class_name RSEFrameSignal
extends RSEFrame


var text_signal: String = ""


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.SignalFrame


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameSignal",
		"text_signal" : text_signal,
	}
