class_name RSEFrameJump
extends RSEFrame


var to_episode_id: int = 0
var description: String = ""


func _init():
	real_frame = true


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Jump


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameJump",
		"to_episode_id" : to_episode_id,
		"description" : description,
	}
