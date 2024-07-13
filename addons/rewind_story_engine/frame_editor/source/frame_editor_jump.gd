@tool
class_name FrameEditorJump
extends FrameEditor


@export var episode: MenuButton
@export var alert: Control
@export var description: TextEdit

var not_selected_color: Color = Color(0.50196081399918, 0.12549020349979, 0.12549020349979)

var episode_selected: bool = false


func _ready():
	_base_setting()
	episode.get_popup().index_pressed.connect(_set_episode)


func _set_episode(index: int) -> void:
	_set_menu_button_index(index, episode, false)
	episode_selected = true
	description.visible = true


func select() -> void:
	_highlight()
	selected.emit(self)
	alert.hide()


func deselect() -> void:
	if episode_selected:
		highlight.hide()
		alert.hide()
	else:
		highlight.color = not_selected_color
		alert.show()


func get_frame() -> RSEFrameJump:
	var frame = RSEFrameJump.new()
	if selected_menu_indicies.has(episode):
		frame.to_episode_id = episode.get_popup().get_item_id(selected_menu_indicies[episode])
	frame.description = description.text
	return frame


func setting(story: RSEStory, frame: RSEFrameJump) -> void:
	self.story = story
	for episode: RSEEpisode in story.episodes.values():
		self.episode.get_popup().add_item(episode.get_id_with_name(), episode.id)
	if frame != null:
		if frame.to_episode_id > 0:
			_set_episode(episode.get_popup().get_item_index(frame.to_episode_id))
		description.text = frame.description
		alert.hide()
