@tool
class_name FrameEditorCondition
extends FrameEditor


@export var condition: LineEdit


func _ready():
	_base_setting()


func get_frame() -> RSEFrameCondition:
	var frame = RSEFrameCondition.new()
	frame.condition = condition.text
	return frame


func setting(story: RSEStory, frame: RSEFrameCondition) -> void:
	self.story = story
	if frame != null:
		condition.text = frame.condition
