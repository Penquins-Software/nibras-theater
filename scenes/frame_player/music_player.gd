class_name MusicPlayer
extends Node


var current_music: RSEMusic


func play(music: RSEMusic) -> void:
	if music == current_music:
		return
