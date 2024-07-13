@tool
class_name FrameEditorCharacter
extends FrameEditor


@export var character: MenuButton
@export var action: MenuButton
@export var emotion: MenuButton
@export var outfit: MenuButton

var selected_character_id: int = -1

var frame: RSEFrameCharacter


func _ready():
	_base_setting()
	character.get_popup().index_pressed.connect(_set_character)
	action.get_popup().index_pressed.connect(_set_action)
	emotion.get_popup().index_pressed.connect(_set_menu_button_index.bind(emotion, true))
	outfit.get_popup().index_pressed.connect(_set_menu_button_index.bind(outfit, true))


func _set_character(index: int) -> void:
	_set_menu_button_index(index, character, false)
	selected_character_id = character.get_popup().get_item_id(index)
	action.visible = true
	setting_emotions()
	setting_outfits()


func _set_action(index: int) -> void:
	_set_menu_button_index(index, action, true)
	emotion.visible = index == 2
	outfit.visible = index == 3


func setting_emotions() -> void:
	emotion.get_popup().clear()
	for emotion_id in story.characters[selected_character_id].emotions:
		emotion.get_popup().add_item(story.characters[selected_character_id].emotions[emotion_id], int(emotion_id))


func setting_outfits() -> void:
	outfit.get_popup().clear()
	for outfit_id in story.characters[selected_character_id].outfits:
		outfit.get_popup().add_item(story.characters[selected_character_id].outfits[outfit_id], int(outfit_id))


func get_frame() -> RSEFrameCharacter:
	if frame == null:
		frame = RSEFrameCharacter.new()
	frame.character_id = selected_character_id
	if selected_menu_indicies.has(action):
		frame.action = action.get_popup().get_item_id(selected_menu_indicies[action])
	if selected_menu_indicies.has(emotion):
		frame.emotion_id = emotion.get_popup().get_item_id(selected_menu_indicies[emotion])
	if selected_menu_indicies.has(outfit):
		frame.outfit_id = outfit.get_popup().get_item_id(selected_menu_indicies[outfit])
	return frame


func setting(story: RSEStory, frame: RSEFrameCharacter) -> void:
	self.story = story
	self.frame = frame

	for character: RSECharacter in story.characters.values():
		if character.active:
			self.character.get_popup().add_item(character.name, character.id)
	
	if frame != null and story.characters.has(frame.character_id):
		_set_character(character.get_popup().get_item_index(frame.character_id))
		_set_action(action.get_popup().get_item_index(frame.action))

		var emotions = story.characters[frame.character_id].emotions as Dictionary
		if emotions.has(str(frame.emotion_id)):
			emotion.text = emotions[str(frame.emotion_id)]
		
		var outfits = story.characters[frame.character_id].outfits as Dictionary
		if outfits.has(str(frame.outfit_id)):
			outfit.text = outfits[str(frame.outfit_id)]


func write_frame_info_to_scene_state(scene_state: EpisodeEditorSceneState) -> void:
	var action_id := 0
	var emotion_id := -1
	var outfit_id := -1
	if selected_menu_indicies.has(action):
		action_id = action.get_popup().get_item_id(selected_menu_indicies[action])
	if selected_menu_indicies.has(emotion):
		emotion_id = emotion.get_popup().get_item_id(selected_menu_indicies[emotion])
	if selected_menu_indicies.has(outfit):
		outfit_id = outfit.get_popup().get_item_id(selected_menu_indicies[outfit])
	match action_id:
		RSECharacter.Action.Join:
			if not scene_state.characters.has(selected_character_id):
				scene_state.characters[selected_character_id] = 0
		RSECharacter.Action.Leave:
			if scene_state.characters.has(selected_character_id):
				scene_state.characters.erase(selected_character_id)
		RSECharacter.Action.Emotion:
			scene_state.characters[selected_character_id] = emotion_id
		RSECharacter.Action.Outfit:
			scene_state.characters[selected_character_id] = outfit_id
