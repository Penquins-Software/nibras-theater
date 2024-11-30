class_name ButtonWithSound
extends Button


func _pressed():
	#_play_sound()
	pass


func _play_sound() -> void:
	UISoundManager.click()
