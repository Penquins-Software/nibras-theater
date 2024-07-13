@tool
class_name GraphStart
extends StoryGraph


var character_port: int = 0
var location_port: int = 1
var visual_effect_port: int = 2
var sound_effect_port: int = 3
var music_port: int = 4
var transitition_port: int = 5

var story_output_port: int = 0


func _init():
	title = "История"
	size = Vector2(200, 200)
	resizable = false
	
	id = 0
	
	_add_empty_slot(8)
	_add_text_slot_left("Персонажи", RSEStoryEditor.SlotType.CHARACTER)
	_add_text_slot_left("Локации", RSEStoryEditor.SlotType.LOCATION)
	_add_text_slot_left("Визуальные эффекты", RSEStoryEditor.SlotType.VISUAL_EFFECT)
	_add_text_slot_left("Звуки", RSEStoryEditor.SlotType.SOUND_EFFECT)
	_add_text_slot_left("Музыка", RSEStoryEditor.SlotType.MUSIC)
	_add_text_slot_left("Переходы", RSEStoryEditor.SlotType.TRANSITITION)
	_add_empty_slot()
	_add_text_slot_right("[right]Начало", RSEStoryEditor.SlotType.EPISODE)
	_add_empty_slot(8)
