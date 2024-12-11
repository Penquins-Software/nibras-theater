class_name Logger
extends Control


@export var text_label: RichTextLabel


func _input(event):
	if event.is_action_pressed("cancel"):
		if visible:
			hide()


func add(frame: RSEFrame, episode: RSEEpisode, current_frame_index: int) -> void:
	if frame is RSEFrameText:
		var speaker = RewindStoryEngine.story.characters[frame.speaker_id]
		var speaker_name = RSECharacter.get_skeaker_name(speaker, episode, current_frame_index)
		if speaker_name != "":
			speaker_name = tr(speaker_name)
			speaker_name += ':'
		var parameters = [speaker.color.to_html(), speaker_name, tr(frame.text)]
		text_label.text += "[cell][right][color=#%s]%s[/color][/right][/cell]	[cell][/cell][cell]%s[/cell]" % parameters
		text_label.text += "[cell][/cell][cell] [/cell][cell][/cell]"
	text_label.scroll_to_line(Constants.INT32_MAX)


func clear_log() -> void:
	text_label.text = "[table=3]"
