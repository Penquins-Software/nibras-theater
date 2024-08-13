extends RSEBaseTransititionController


func _on_audio_stream_player_finished():
	ended.emit()
	queue_free()
