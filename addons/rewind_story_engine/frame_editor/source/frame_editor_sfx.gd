@tool
class_name FrameEditorSFX
extends FrameEditor


@export var open_file_button: Button
@export var path_to_file_label: Label
@export var file_dialog: FileDialog


func _ready():
	_base_setting()
	open_file_button.pressed.connect(file_dialog.show)


func _on_file_dialog_file_selected(path):
	path_to_file_label.visible = true
	path_to_file_label.text = path
	updated.emit(self)


func get_frame() -> RSEFrameSFX:
	var frame = RSEFrameSFX.new()
	frame.path_to_audio = path_to_file_label.text
	return frame


func setting(story: RSEStory, frame: RSEFrameSFX) -> void:
	self.story = story
	if frame != null:
		path_to_file_label.visible = true
		path_to_file_label.text = frame.path_to_audio
