class_name BleepPlayer
extends AudioStreamPlayer


var is_playing: bool = false


func _ready():
	finished.connect(_replay)


func _play() -> void:
	is_playing = true
	play()


func _stop() -> void:
	is_playing = false
	await finished
	if not is_playing:
		stop()


func _replay() -> void:
	volume_db = randf_range(-2.0, 2.0)
	pitch_scale = randf_range(0.8, 1.2)
	play()
