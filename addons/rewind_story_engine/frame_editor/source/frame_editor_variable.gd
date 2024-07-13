@tool
class_name FrameEditorVariable
extends FrameEditor


@export var variable_line_edit: LineEdit
@export var value_line_edit: LineEdit


func _ready():
	_base_setting()
	variable_line_edit.gui_input.connect(_gui_input_without_popup)
	value_line_edit.gui_input.connect(_gui_input_without_popup)


func get_frame() -> RSEFrameVariable:
	var frame = RSEFrameVariable.new()
	frame.name = variable_line_edit.text
	frame.value = value_line_edit.text
	return frame


func setting(story: RSEStory, frame: RSEFrameVariable) -> void:
	self.story = story
	if frame != null:
		variable_line_edit.text = frame.name
		value_line_edit.text = frame.value
