@tool
class_name FrameEditorSelection
extends FrameEditor


const OptionScene: PackedScene = preload("res://addons/rewind_story_engine/frame_editor/selection_option.tscn")


@export var options_container: Control
@export var add_option_button: Button


func _ready():
	_base_setting()


func get_frame() -> RSEFrameSelection:
	var frame = RSEFrameSelection.new()
	for child in options_container.get_children():
		if child is FrameEditorSelectionOption:
			frame.options.append([child.to_episode_id, child.option_line_edit.text])
	return frame


func setting(story: RSEStory, frame: RSEFrameSelection) -> void:
	self.story = story
	if frame != null:
		for option_info in frame.options:
			var option = OptionScene.instantiate()
			option.setting(story, option_info[0], option_info[1])
			options_container.add_child(option)
			add_option_button.move_to_front()


func _on_add_option_pressed():
	var option = OptionScene.instantiate()
	option.setting(story)
	options_container.add_child(option)
	add_option_button.move_to_front()
