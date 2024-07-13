@tool
class_name FrameEditorSignal
extends FrameEditor


@export var signal_line_edit: LineEdit


func _ready():
	_base_setting()
	signal_line_edit.gui_input.connect(_gui_input_without_popup)


func get_frame() -> RSEFrameSignal:
	var frame = RSEFrameSignal.new()
	frame.text_signal = signal_line_edit.text
	return frame


func setting(story: RSEStory, frame: RSEFrameSignal) -> void:
	self.story = story
	if frame != null:
		signal_line_edit.text = frame.text_signal
