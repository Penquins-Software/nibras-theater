class_name RSEFrameEndCondition
extends RSEFrame


var condition: RSEFrameCondition


# func _init():
# 	real_frame = true


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.EndCondition


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameEndCondition",
	}


func print_info() -> void:
	print_rich("[i][color=INDIAN_RED]Окончание условия: %s" % condition.condition)
