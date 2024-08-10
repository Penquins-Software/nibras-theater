@tool
class_name RSESceneBuilder
extends Node2D


signal last_frame()
signal music(music_id: int)
signal bgs(bgs_id: int, status: bool)


var episode: RSEEpisode
var current_frame_index: int = -1

var current_music_id: int = -1
var current_bgs_ids: Array[int] = []

var camera_controller: RSEBaseCameraController

var location: RSELocation
var location_node: RSEBaseLocationController
var characters: Dictionary
var visual_effects: Dictionary
var sound_effects: Dictionary


func set_episode(episode: RSEEpisode) -> void:
	clear_scene()
	self.episode = episode
	current_frame_index = -1
	
	if episode == null:
		return
	
	camera_controller = RSEBaseCameraController.new()
	add_child(camera_controller)
	
	if Engine.is_editor_hint():
		camera_controller.add_border()
		Node2DDragger.new(camera_controller)
	else:
		camera_controller.camera.make_current()


func clear_scene() -> void:
	for child in get_children():
		child.queue_free()
	
	if is_instance_valid(camera_controller):
		camera_controller.queue_free()
	
	location = null
	location_node = null
	characters.clear()
	visual_effects.clear()
	sound_effects.clear()
	
	current_music_id = -1
	current_bgs_ids.clear()


func prev_frame() -> int:
	if episode == null:
		return 0
	
	if current_frame_index > 0:
		save_scene_preset()
		current_frame_index -= 1
		var frame: RSEFrame = episode.real_frames[current_frame_index]
		build_frame(frame, false)
	
	return current_frame_index


func next_frame() -> int:
	if episode == null:
		return 0
	
	if current_frame_index < episode.real_frames.size() - 1:
		save_scene_preset()
		current_frame_index += 1
		var frame: RSEFrame = episode.real_frames[current_frame_index]
		build_frame(frame, true)
		if episode.real_frames.size() - 1 == current_frame_index:
			last_frame.emit()
	
	return current_frame_index


func set_frame(frame_index: int) -> int:
	if episode == null:
		return 0
	
	if episode.real_frames.size() == 0:
		return 0
	
	save_scene_preset()
	
	if frame_index < 0:
		frame_index = 0
	
	if frame_index > episode.real_frames.size():
		frame_index = episode.real_frames.size() - 1
	
	var is_next: bool = false
	if current_frame_index < frame_index:
		is_next = true

	current_frame_index = frame_index
	build_frame(episode.real_frames[frame_index], is_next)
	return current_frame_index


func build_frame(frame: RSEFrame, is_next: bool) -> void:
	var scene_state = frame.scene_state
	
	if scene_state.location_id > -1 and episode.story.locations.has(scene_state.location_id):
		var location: RSELocation = episode.story.locations[scene_state.location_id]
		set_location(location)
	
	for character_id in characters.keys():
		if not scene_state.characters.has(character_id):
			if is_instance_valid(characters[character_id]):
				characters[character_id].queue_free()
			characters.erase(character_id)
	for character_id in scene_state.characters:
		var character: RSEBaseCharacterController
		if not characters.has(character_id):
			character = add_character(episode.story.characters[character_id])
		else:
			character = characters[character_id]
		if character != null:
			character.set_emotion(scene_state.characters[character_id]["emotion_id"])
			character.set_outfit(scene_state.characters[character_id]["outfit_id"])
	
	for visual_effect_id in visual_effects:
		if not scene_state.visual_effect_ids.has(visual_effect_id):
			visual_effects[visual_effect_id].queue_free()
			visual_effects.erase(visual_effect_id)
	for visual_effect_id in scene_state.visual_effect_ids:
		if not visual_effects.has(visual_effect_id):
			add_visual_effect(episode.story.visual_effects[visual_effect_id])
	
	if current_music_id != scene_state.music_id:
		current_music_id = scene_state.music_id
		music.emit(current_music_id)
	
	for bgs_id in current_bgs_ids:
		if not scene_state.sound_effect_ids.has(bgs_id):
			current_bgs_ids.erase(bgs_id)
			bgs.emit(bgs_id, false)
	for bgs_id in scene_state.sound_effect_ids:
		if not current_bgs_ids.has(bgs_id):
			current_bgs_ids.append(bgs_id)
			bgs.emit(bgs_id, true)
	
	apply_scene_preset()
	show_frame_info()


func set_location(location: RSELocation) -> void:
	if self.location == location:
		return
	
	self.location = location

	if is_instance_valid(location_node):
		location_node.queue_free()
	
	if location.path_to_scene == "":
		return
	
	location_node = load(location.path_to_scene).instantiate()
	add_child(location_node)
	
	Node2DDragger.new(location_node)


func add_character(character: RSECharacter) -> RSEBaseCharacterController:
	if character.path_to_scene == "":
		return null
	
	var character_node: RSEBaseCharacterController = load(character.path_to_scene).instantiate()
	character_node.character = character
	add_child(character_node)
	characters[character.id] = character_node
	Node2DDragger.new(character_node)
	return character_node


func add_visual_effect(visual_effect: RSEVisualEffect) -> RSEBaseVisualEffectController:
	if visual_effect.path_to_scene == "":
		return null
	
	var visual_effect_node: RSEBaseVisualEffectController = load(visual_effect.path_to_scene).instantiate()
	visual_effect_node.visual_effect = visual_effect
	add_child(visual_effect_node)
	visual_effects[visual_effect.id] = visual_effect_node
	Node2DDragger.new(visual_effect_node)
	return visual_effect_node


func save_scene_preset() -> void:
	if not Engine.is_editor_hint():
		return
	
	if episode == null:
		return

	if current_frame_index < 0 or current_frame_index > episode.scene_presets.size() - 1:
		return
	
	var scene_preset = RSEScenePreset.new()
	scene_preset.add_camera_preset(camera_controller)
	if location_node != null:
		scene_preset.add_location_preset(location_node)
	for character in characters.values():
		scene_preset.add_character_preset(character)
	for visual_effect in visual_effects.values():
		scene_preset.add_visual_effect_preset(visual_effect)
	episode.scene_presets[current_frame_index] = scene_preset


func apply_scene_preset() -> void:
	if current_frame_index < 0 or current_frame_index > episode.scene_presets.size() - 1:
		camera_controller.camera.zoom = Vector2(0.5, 0.5)
		camera_controller.scale = Vector2(2, 2)
		return
	
	var scene_preset = episode.scene_presets[current_frame_index]
	if scene_preset == null:
		camera_controller.camera.zoom = Vector2(0.5, 0.5)
		camera_controller.scale = Vector2(2, 2)
		return
	
	scene_preset.apply_preset_to_camera(camera_controller)
	if location_node != null:
		scene_preset.apply_preset_to_location(location_node)
	for character_id in characters:
		scene_preset.apply_preset_to_character(characters[character_id])
	for visual_effect_id in visual_effects:
		scene_preset.apply_preset_to_visual_effect(visual_effects[visual_effect_id])


func inherit_scene_preset_from_prev_frame() -> void:
	if episode == null:
		return
	
	if current_frame_index == 0:
		return
	
	var prev_frame_scene_preset = episode.scene_presets[current_frame_index - 1]
	episode.scene_presets[current_frame_index] = prev_frame_scene_preset
	
	apply_scene_preset()

	print("Состояние сцены успешно наследовано.")


func inherit_scene_preset_from_next_frame() -> void:
	if episode == null:
		return
	
	if current_frame_index >= episode.real_frames.size() - 1:
		return
	
	var next_frame_scene_preset = episode.scene_presets[current_frame_index + 1]
	episode.scene_presets[current_frame_index] = next_frame_scene_preset
	
	apply_scene_preset()

	print("Состояние сцены успешно наследовано.")


func reset_scene_preset() -> void:
	if episode == null:
		return
	
	var scene_preset = RSEScenePreset.new()
	episode.scene_presets[current_frame_index] = scene_preset
	
	camera_controller.reset()
	scene_preset.add_camera_preset(camera_controller)
	
	if location_node != null:
		location_node.reset()
		scene_preset.add_location_preset(location_node)
	for character in characters.values():
		character.reset()
		scene_preset.add_character_preset(character)
	for visual_effect in visual_effects.values():
		visual_effect.reset()
		scene_preset.add_visual_effect_preset(visual_effect)


func show_frame_info() -> void:
	if Engine.is_editor_hint():
		var frame = episode.real_frames[current_frame_index]
		frame.print_info()


func _input(event):
	if not Engine.is_editor_hint():
		return
	
	if is_instance_valid(camera_controller):
		camera_controller.dragger._input(event)
	if is_instance_valid(location_node):
		location_node.dragger._input(event)
	for character: RSEBaseCharacterController in characters.values():
		character.dragger._input(event)
	for visual_effect: RSEBaseVisualEffectController in visual_effects.values():
		visual_effect.dragger._input(event)


func get_characeter_by_id(id: int) -> RSEBaseCharacterController:
	if characters.has(id):
		return characters[id]
	
	return null
