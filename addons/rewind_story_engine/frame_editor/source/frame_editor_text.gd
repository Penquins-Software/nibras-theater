@tool
class_name FrameEditorText
extends FrameEditor


@export var character: MenuButton
@export var text_edit: TextEdit


func _ready():
	_base_setting()
	character.get_popup().index_pressed.connect(_set_menu_button_index.bind(character, false))
	text_edit.gui_input.connect(_gui_input_without_popup)


func get_frame() -> RSEFrameText:
	var frame = RSEFrameText.new()
	if selected_menu_indicies.has(character):
		frame.speaker_id = character.get_popup().get_item_id(selected_menu_indicies[character])
	frame.text = text_edit.text
	return frame


func setting(story: RSEStory, frame: RSEFrameText) -> void:
	self.story = story
	for character: RSECharacter in story.characters.values():
		if character.active:
			self.character.get_popup().add_item(character.name, character.id)
	if frame != null:
		if frame.speaker_id > 0:
			_set_menu_button_index(character.get_popup().get_item_index(frame.speaker_id), character, false)
		text_edit.text = frame.text
