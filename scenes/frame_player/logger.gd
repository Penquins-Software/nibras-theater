class_name Logger
extends Control


@export var text_label: RichTextLabel


func _input(event):
	if event.is_action_pressed("cancel"):
		if visible:
			hide()


func add(frame: RSEFrame) -> void:
	if frame is RSEFrameText:
		var speaker = RewindStoryEngine.story.characters[frame.speaker_id]
		var speaker_name = speaker.display_name
		if speaker_name != "":
			speaker_name += ':'
		var parameters = [speaker.color.to_html(), speaker_name, frame.text]
		text_label.text += "[cell][right][color=#%s]%s[/color][/right][/cell][cell][/cell][cell]%s[/cell]" % parameters
	text_label.scroll_to_line(Constants.INT32_MAX)


func _on_close_pressed():
	hide()
