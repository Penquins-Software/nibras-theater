class_name BGSPlayer
extends Node


var players: Dictionary = {}


func play(bgs: AudioStream) -> void:
	if players.has(bgs):
		return
	
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.bus = &"SFX"
	audio_player.stream = bgs
	audio_player.play()
	
	players[bgs] = audio_player


func stop(bgs: AudioStream) -> void:
	if players.has(bgs):
		players[bgs].queue_free()
		players.erase(bgs)


func clear() -> void:
	for player_key in players:
		players[player_key].queue_free()
	players.clear()
