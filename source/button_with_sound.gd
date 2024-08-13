class_name ButtonWithSound
extends Button


func _pressed():
	_play_sound()


func _play_sound() -> void:
	UISoundManager.click()
