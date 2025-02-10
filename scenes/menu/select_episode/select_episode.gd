class_name SelectEpisode
extends MenuElement


@export var menu: Menu
@export var episodes: Control


func has_not_viewed() -> bool:
	for episode: Episode in episodes.get_children():
		if not episode.is_viewed():
			return true
	
	return false
