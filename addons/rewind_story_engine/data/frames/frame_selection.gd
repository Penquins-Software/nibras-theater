class_name RSEFrameSelection
extends RSEFrame


var options: Array


func _init():
	real_frame = true


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Selection


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameSelection",
		"options" : options,
	}


func print_info() -> void:
	print("Selection options: %s" % options)
