class_name RSEFrameTransitition
extends RSEFrame


var transitition_id: int = 0


func _init():
	real_frame = true


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Transitition


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameTransitition",
		"transitition_id" : transitition_id,
	}


func print_info() -> void:
	print_rich("[i][color=INDIAN_RED]Эффект перехода")
