class_name TextureButtonWithSound
extends TextureButton


func _pressed():
	_play_sound()


func _play_sound() -> void:
	UISoundManager.click()
