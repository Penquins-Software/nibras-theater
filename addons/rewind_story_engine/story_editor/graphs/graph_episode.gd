@tool
class_name GraphEpisode
extends StoryGraph


var episode: RSEEpisode

var episode_title: LineEdit
var episode_description: TextEdit
var episode_frames: RichTextLabel

var input_port: int = 0


func _init(episode: RSEEpisode):
	self.episode = episode
	id = episode.id
	
	title = "Эпизод"
	size = Vector2(200, 300)
	resizable = true
	
	_add_empty_slot(8)
	episode_title = _add_line_edit_slot("Название эпизода").get_child(0) as LineEdit
	_add_empty_slot(8)
	_add_text_slot("ID: %s" % id)
	episode_frames = _add_text_slot("Кадры: %s" % episode.frames.size()).get_child(0) as RichTextLabel
	_add_empty_slot()
	_add_text_slot_left("Вход", RSEStoryEditor.SlotType.EPISODE)
	_add_empty_slot()
	var index := 0
	for exit in episode.exits:
		var exit_description = exit["description"]
		if exit_description == "":
			exit_description = "[right]Выход %s" % index
		_add_text_slot_right("[right]%s" % exit_description, RSEStoryEditor.SlotType.EPISODE)
		index += 1
	_add_empty_slot()
	episode_description = _add_text_edit_slot("Описание").get_child(0) as TextEdit
	
	episode_title.text = episode.name
	episode_description.text = episode.description
	
	episode_title.text_changed.connect(_on_title_changed)
	episode_description.text_changed.connect(_on_description_changed)


func _on_title_changed(new_text: String) -> void:
	episode.name = new_text


func _on_description_changed() -> void:
	episode.description = episode_description.text


func on_connect_from(from_node: StoryGraph, from_port: int, to_port: int) -> void:
	if from_node.id == 0:
		episode.start = true


func on_connect_to(to_node: StoryGraph, from_port: int, to_port: int) -> void:
	var frame_index = episode.exits[from_port]["frame_index"]
	var frame = episode.frames[frame_index]
	if frame is RSEFrameJump:
		frame.to_episode_id = to_node.id
	elif frame is RSEFrameSelection:
		var exit_index = episode.exits[from_port]["index"]
		var to_episode_id = episode.exits[from_port]["to_episode_id"]
		var description = episode.exits[from_port]["description"]
		frame.options[exit_index] = [to_node.id, description]


func on_disconnect_from(from_node: StoryGraph, from_port: int, to_port: int) -> void:
	episode.start = false


func on_disconnect_to(to_node: StoryGraph, from_port: int, to_port: int) -> void:
	var frame_index = episode.exits[from_port]["frame_index"]
	var frame = episode.frames[frame_index]
	if frame is RSEFrameJump:
		frame.to_episode_id = -1
	elif frame is RSEFrameSelection:
		var exit_index = episode.exits[from_port]["index"]
		var description = episode.exits[from_port]["description"]
		frame.options[exit_index] = [-1, description]


func delete() -> void:
	episode.story.episodes.erase(episode.id)
	queue_free()
