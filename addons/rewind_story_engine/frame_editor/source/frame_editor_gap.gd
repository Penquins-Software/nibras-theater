@tool
class_name FrameEditorGap
extends FrameEditor


func _ready():
	_base_setting()


func get_frame() -> RSEFrameGap:
	var frame = RSEFrameGap.new()
	return frame
