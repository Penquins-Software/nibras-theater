@tool
class_name FrameEditorEndCondition
extends FrameEditor


func _ready():
	_base_setting()


func get_frame() -> RSEFrameEndCondition:
	var frame = RSEFrameEndCondition.new()
	return frame
