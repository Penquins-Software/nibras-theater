class_name RSEFrameSFX
extends RSEFrame


var path_to_audio: String


func _init():
	real_frame = true


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.SFX


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameSFX",
		"path_to_audio" : path_to_audio,
	}
