class_name RSEFrameGap
extends RSEFrame


func _init():
	real_frame = true


func write_frame_info_to_scene_state(scene_state: RSESceneState) -> void:
	scene_state.gap = true


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Gap


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameGap",
	}


func print_info() -> void:
	print_rich("[i][color=INDIAN_RED]Переход на следующий кадр")
