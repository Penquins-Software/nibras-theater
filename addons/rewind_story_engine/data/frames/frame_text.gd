class_name RSEFrameText
extends RSEFrame


var speaker_id: int = 0
var text: String = ""


func _init():
	real_frame = true


func write_frame_info_to_scene_state(scene_state: RSESceneState) -> void:
	var rewrite: bool = scene_state.gap
	if not rewrite:
		rewrite = speaker_id != scene_state.speaker_id
	if not rewrite:
		rewrite = (scene_state.text + text).length() > RewindStoryEngine.MAX_SYMBOLS
	
	if rewrite:
		scene_state.gap = false
		scene_state.speaker_id = speaker_id
		scene_state.text = tr(text)
	else:
		scene_state.text += ' ' + tr(text)


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Text


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameText",
		"speaker_id" : speaker_id,
		"text" : text,
	}


func print_info() -> void:
	if RewindStoryEngine.story.characters.has(speaker_id):
		var character: RSECharacter = RewindStoryEngine.story.characters[speaker_id]
		print_rich("[color=#%s]%s[/color]: %s" % [character.color.to_html(), character.name, text])
