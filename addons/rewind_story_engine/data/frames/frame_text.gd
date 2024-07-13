class_name RSEFrameText
extends RSEFrame


var speaker_id: int = 0
var text: String = ""


func _init():
	real_frame = true


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
