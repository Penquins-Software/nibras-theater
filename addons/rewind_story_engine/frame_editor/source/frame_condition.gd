@tool
class_name FrameEditorCondition
extends FrameEditor


@export var condition: LineEdit
@export var global_check_box: CheckBox


func _ready():
	_base_setting()


func get_frame() -> RSEFrameCondition:
	var frame = RSEFrameCondition.new()
	frame.condition = condition.text
	frame.global = global_check_box.button_pressed
	return frame


func setting(story: RSEStory, frame: RSEFrameCondition) -> void:
	self.story = story
	if frame != null:
		condition.text = frame.condition
		global_check_box.button_pressed = frame.global
