@tool
class_name GraphMusic
extends StoryGraph


var music: RSEMusic

var music_name: LineEdit


func _init(music: RSEMusic):
	self.music = music
	id = music.id
	
	title = "Музыка"
	size = Vector2(200, 40)
	resizable = false
	
	_add_empty_slot(8)
	music_name = _add_line_edit_slot("Название трека").get_child(0) as LineEdit
	_add_empty_slot(8)
	_add_text_slot("ID: %s" % id)
	_add_empty_slot()
	_add_text_slot_right("[right]История", RSEStoryEditor.SlotType.MUSIC)
	_add_empty_slot(8)
	
	music_name.text = music.name
	
	music_name.text_changed.connect(_on_name_changed)


func _on_name_changed(new_text: String) -> void:
	music.name = new_text


func on_connect_to(to_node: GraphNode, from_port: int, to_port: int) -> void:
	music.active = true


func on_disconnect_to(to_node: GraphNode, from_port: int, to_port: int) -> void:
	music.active = false
