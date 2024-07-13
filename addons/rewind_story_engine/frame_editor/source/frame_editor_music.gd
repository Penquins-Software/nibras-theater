@tool
class_name FrameEditorMusic
extends FrameEditor


@export var music: MenuButton


func _ready():
	_base_setting()
	music.get_popup().index_pressed.connect(_set_menu_button_index.bind(music, false))


func get_frame() -> RSEFrameMusic:
	var frame = RSEFrameMusic.new()
	if selected_menu_indicies.has(music):
		frame.music_id = music.get_popup().get_item_id(selected_menu_indicies[music])
	return frame


func setting(story: RSEStory, frame: RSEFrameMusic) -> void:
	self.story = story
	for ms: RSEMusic in story.music_list.values():
		if ms.active:
			music.get_popup().add_item(ms.name, ms.id)
	if frame != null:
		if story.music_list.has(frame.music_id):
			_set_menu_button_index(music.get_popup().get_item_index(frame.music_id), music, false)
