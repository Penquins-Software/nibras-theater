@tool
class_name FrameEditorComment
extends FrameEditor


@export var text_edit: TextEdit


func _ready():
	_base_setting()
	text_edit.gui_input.connect(_gui_input_without_popup)


func get_frame() -> RSEFrameComment:
	var frame = RSEFrameComment.new()
	frame.text = text_edit.text
	return frame


func setting(story: RSEStory, frame: RSEFrameComment) -> void:
	self.story = story
	text_edit.text = frame.text
