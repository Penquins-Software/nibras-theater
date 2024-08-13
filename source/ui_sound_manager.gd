extends AudioStreamPlayer


var click_sound = preload("res://audio/sfx/select.mp3")


func _enter_tree():
	bus = &"SFX"


func play_sound(audio: AudioStream) -> void:
	stream = audio
	play()


func click() -> void:
	stream = click_sound
	play()
