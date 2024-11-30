class_name TextBox
extends Control


signal finished()


enum MarkerMode {
	NextText,
	NextFrame,
}


const MAX_SYMBOLS: int = 200
const BB_CODE_NEXT_TEXT: String = "  [img=24]res://gui/Мелочи/Игра/Для текста/1.png[/img]"


@export var speaker_label: RichTextLabel
@export var text_label: RichTextLabel
@export var marker: TextureRect


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
	print_time = float(get_clear_text_length()) / Settings.text_speed
	text_label.visible_characters = -1
	if marker_mode == MarkerMode.NextText:
		#marker.texture = marker_next_text
		add_bbcode_marker()
	elif marker_mode == MarkerMode.NextFrame:
		marker.show()


func set_text(text: String, speaker: String = "", speaker_color: Color = Color.WHITE, mode: MarkerMode = MarkerMode.NextFrame, immediately: bool = false) -> void:
	if not ready_to_next_frame:
		return
	
	text = tr(text)
	speaker = tr(speaker)
	
	remove_bbcode_marker()
	
	text_label.text = text
	_speaker = speaker
	print_time = 0
	text_label.visible_ratio = 0
	showing = true
	ready_to_next_frame = false
	marker.hide()
	if get_clear_text_length() > MAX_SYMBOLS:
		mode = MarkerMode.NextFrame
	marker_mode = mode
	speaker_label.text = "[b][color=#%s]%s" % [speaker_color.to_html(), speaker]
	
	if immediately:
		end_frame()


func add_text(text: String, speaker: String = "", speaker_color: Color = Color.WHITE, mode: MarkerMode = MarkerMode.NextFrame) -> void:
	if not ready_to_next_frame:
		return
	
	text = tr(text)
	speaker = tr(speaker)
	
	if text_label.text == "":
		set_text(text, speaker, speaker_color, mode)
		return
	
	if get_clear_text_length() + text.length() > MAX_SYMBOLS:
		set_text(text, speaker, speaker_color, mode)
		return
	
	if _speaker != speaker:
		set_text(text, speaker, speaker_color, mode)
		return
	
	remove_bbcode_marker()
	
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


func get_clear_text_length() -> int:
	return text_label.text.replace(BB_CODE_NEXT_TEXT, "").length()


func add_bbcode_marker() -> void:
	text_label.text += BB_CODE_NEXT_TEXT


func remove_bbcode_marker() -> void:
	text_label.text = text_label.text.replace(BB_CODE_NEXT_TEXT, "")
