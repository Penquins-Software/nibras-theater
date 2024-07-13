@tool
class_name FrameEditorEraseScene
extends FrameEditor


func _ready():
	_base_setting()


func get_frame() -> RSEFrameEraseScene:
	var frame = RSEFrameEraseScene.new()
	return frame
