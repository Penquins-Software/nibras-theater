@tool
class_name FrameEditorSelectionOption
extends Control


@export var option_line_edit: LineEdit
@export var to_episode_menu_button: MenuButton
@export var remove_button: Button


var to_episode_id: int = -1


func _ready():
	to_episode_menu_button.get_popup().index_pressed.connect(_episode_was_selected)


func _episode_was_selected(index: int) -> void:
	to_episode_id = to_episode_menu_button.get_popup().get_item_id(index)
	to_episode_menu_button.text = to_episode_menu_button.get_popup().get_item_text(index)


func setting(story: RSEStory, to_ep_id: int = -1, option_text: String = "") -> void:
	for episode: RSEEpisode in story.episodes.values():
		to_episode_menu_button.get_popup().add_item(episode.get_id_with_name(), episode.id)
	
	to_episode_id = to_ep_id
	option_line_edit.text = option_text
	if to_ep_id != -1:
		var index = to_episode_menu_button.get_popup().get_item_index(to_ep_id)
		to_episode_menu_button.text = to_episode_menu_button.get_popup().get_item_text(index)


func _on_remove_button_pressed():
	queue_free()
