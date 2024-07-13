class_name RSEEpisode
extends RefCounted

var story: RSEStory

var id: int
var name: String
var description: String
var frames: Array[RSEFrame] : set = _set_frames
var real_frames: Array[RSEFrame]
var scene_presets: Array[RSEScenePreset]
var active: bool = false

var start: bool = false
var exits: Array = []


func _init(story: RSEStory, id: int):
	self.story = story
	self.id = id


func _set_frames(f: Array[RSEFrame]) ->void:
	frames = f
	get_exits()
	create_scene_state_for_every_frame()
	get_real_frames()


func get_id_with_name() -> String:
	var name = self.name
	if name == "":
		name = "[Без названия]"
	return "%s: %s" % [id, name]


func create_scene_state_for_every_frame() -> void:
	var scene_state := RSESceneState.new()
	for frame in frames:
		frame.write_frame_info_to_scene_state(scene_state)
		frame.scene_state = scene_state.make_copy()


func get_real_frames() -> void:
	real_frames.clear()
	for frame in frames:
		if frame.real_frame:
			real_frames.append(frame)
	scene_presets.resize(real_frames.size())


func get_scene_state(frame_index: int) -> RSESceneState:
	if frame_index > frames.size():
		return
	
	var scene_state := RSESceneState.new()
	
	for index in range(0, frame_index):
		frames[index].write_frame_info_to_scene_state(scene_state)
	
	return scene_state


func get_exits() -> Array:
	exits.clear()
	
	var frame_index := 0
	for frame in frames:
		if frame is RSEFrameJump:
			exits.append({
				"frame_index" : frame_index,
				"to_episode_id" : frame.to_episode_id,
				"description" : frame.description,
			})
		elif frame is RSEFrameSelection:
			var index := 0
			for option in frame.options:
				exits.append({
					"frame_index" : frame_index,
					"to_episode_id" : option[0],
					"description" : option[1],
					"index" : index,
				})
				index += 1
		frame_index += 1
	return exits


func save_to_dictionary() -> Dictionary:
	var data := {
		"id" : id,
		"name" : name,
		"description" : description,
		"active" : active,
		"start" : start,
	}
	
	var frame_info_array = []
	for frame in frames:
		frame_info_array.append(frame.save_frame_to_dictionary())
	data["frames"] = frame_info_array
	
	var scene_presets_info = []
	for scene_preset in scene_presets:
		if scene_preset == null:
			scene_presets_info.append(null)
		else:
			scene_presets_info.append(scene_preset.save_to_dictionary())
	data["scene_presets"] = scene_presets_info

	return data


static func load_from_dictionary(story: RSEStory, data: Dictionary) -> RSEEpisode:
	var episode = RSEEpisode.new(story, data["id"])
	
	episode.name = data["name"]
	episode.description = data["description"]
	episode.active = data["active"]
	episode.start = data["start"]
	
	for frame_info in data["frames"]:
		episode.frames.append(RSEFrame.load_frame_from_dictionary(frame_info))
	
	for scene_preset in data["scene_presets"]:
		if scene_preset == null:
			episode.scene_presets.append(null)
		else:
			episode.scene_presets.append(RSEScenePreset.load_from_dictionary(scene_preset))
		
	episode.get_exits()
	episode.create_scene_state_for_every_frame()
	episode.get_real_frames()
	
	return episode
