@tool
extends Node


const MAX_SYMBOLS: int = 200


var story: RSEStory


func _notification(what):
	if story == null:
		return
	
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		for episode: RSEEpisode in story.episodes.values():
			episode.create_scene_state_for_every_frame()
