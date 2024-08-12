class_name TextBox
extends Control


signal finished()


enum MarkerMode {
	NextText,
	NextFrame,
}


const MAX_SYMBOLS: int = 200


@export var speaker_label: RichTextLabel
@export var text_label: RichTextLabel
@export var marker: TextureRect

@export var marker_next_text: Texture2D
@export var marker_next_frame: Texture2D


var _speaker: String
var print_time: float = 0
var showing: bool = false
var ready_to_next_frame: bool = true
var marker_mode: MarkerMode


func _process(delta):
	if not showing:
		return
	
	print_time += delta
	text_label.visible_characters = print_time * Settings.text_speed
	
	if text_label.visible_ratio >= 1:
		end_frame()


func end_frame() -> void:
	showing = false
	ready_to_next_frame = true
	finished.emit()
	marker.show()
	print_time = float(text_label.text.length()) / Settings.text_speed
	text_label.visible_characters = -1
	if marker_mode == MarkerMode.NextText:
		marker.texture = marker_next_text
	elif marker_mode == MarkerMode.NextFrame:
		marker.texture = marker_next_frame


func set_text(text: String, speaker: String = "", speaker_color: Color = Color.WHITE, mode: MarkerMode = MarkerMode.NextFrame, immediately: bool = false) -> void:
	if not ready_to_next_frame:
		return
	
	text_label.text = text
	_speaker = speaker
	print_time = 0
	text_label.visible_ratio = 0
	showing = true
	ready_to_next_frame = false
	marker.hide()
	if text_label.text.length() > MAX_SYMBOLS:
		mode = MarkerMode.NextFrame
	marker_mode = mode
	speaker_label.text = "[b][color=#%s]%s" % [speaker_color.to_html(), speaker]
	
	if immediately:
		end_frame()


func add_text(text: String, speaker: String = "", speaker_color: Color = Color.WHITE, mode: MarkerMode = MarkerMode.NextFrame) -> void:
	if not ready_to_next_frame:
		return
	
	if text_label.text == "":
		set_text(text, speaker, speaker_color, mode)
		return
	
	if (text_label.text + text).length() > MAX_SYMBOLS:
		set_text(text, speaker, speaker_color, mode)
		return
	
	if _speaker != speaker:
		set_text(text, speaker, speaker_color, mode)
		return
	
	text_label.text += ' ' + text
	showing = true
	ready_to_next_frame = false
	marker.hide()
	marker_mode = mode


func clear() -> void:
	speaker_label.text = ""
	text_label.text = ""
	print_time = 0
	text_label.visible_characters = 0
