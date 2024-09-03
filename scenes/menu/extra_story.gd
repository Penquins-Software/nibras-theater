class_name ExtraStory
extends Button


@export var menu: Menu
@export var episode_id: int


func _pressed():
	UISoundManager.click()
	var save = Save.new(null, episode_id, 0, {})
	menu.load_game(save)
