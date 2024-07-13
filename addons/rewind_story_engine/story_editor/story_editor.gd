@tool
class_name RSEStoryEditor
extends Control

enum SlotType
{
	NONE,
	EPISODE,
	CHARACTER,
	LOCATION,
	VISUAL_EFFECT,
	SOUND_EFFECT,
	MUSIC,
	TRANSITITION,
}

const SlotColors = {
	SlotType.NONE: Color.WHITE,
	SlotType.EPISODE: Color.GREEN_YELLOW,
	SlotType.CHARACTER: Color.AQUA,
	SlotType.LOCATION: Color.DARK_RED,
	SlotType.VISUAL_EFFECT: Color.SANDY_BROWN,
	SlotType.SOUND_EFFECT: Color.DEEP_PINK,
	SlotType.MUSIC: Color.DARK_VIOLET,
	SlotType.TRANSITITION: Color.GOLD,
}

signal open_edit_episode(episode: RSEEpisode)

@export var graph_edit: GraphEdit
@export var edit_popup_menu: PopupMenu
@export var add_popup_menu: PopupMenu
@export var confimation_dialog: ConfirmationDialog
@export var story_title_edit: LineEdit

var start_node: GraphStart

var selected_nodes: Array[GraphNode]

var story: RSEStory


func _add_start(state: Dictionary = {}) -> void:
	start_node = GraphStart.new()
	_place_graph_node(start_node, state)


func _add_episode(ep: RSEEpisode = null, state: Dictionary = {}) -> GraphEpisode:
	if ep == null:
		ep = story.add_episode()
	var graph_node = GraphEpisode.new(ep)
	_place_graph_node(graph_node, state)
	return graph_node


func _add_character(character: RSECharacter = null, state: Dictionary = {}) -> GraphCharacter:
	if character == null:
		character = story.add_character()
	var graph_node = GraphCharacter.new(character)
	_place_graph_node(graph_node, state)
	return graph_node


func _add_location(location: RSELocation = null, state: Dictionary = {}) -> GraphLocation:
	if location == null:
		location = story.add_location()
	var graph_node = GraphLocation.new(location)
	_place_graph_node(graph_node, state)
	return graph_node


func _add_visual_effect(visual_effect: RSEVisualEffect = null, state: Dictionary = {}) -> GraphVisualEffect:
	if visual_effect == null:
		visual_effect = story.add_visual_effect()
	var graph_node = GraphVisualEffect.new(visual_effect)
	_place_graph_node(graph_node, state)
	return graph_node


func _add_sound_effect(sound_effect: RSESoundEffect = null, state: Dictionary = {}) -> GraphSoundEffect:
	if sound_effect == null:
		sound_effect = story.add_sound_effect()
	var graph_node = GraphSoundEffect.new(sound_effect)
	_place_graph_node(graph_node, state)
	return graph_node


func _add_music(music: RSEMusic = null, state: Dictionary = {}) -> GraphMusic:
	if music == null:
		music = story.add_music()
	var graph_node = GraphMusic.new(music)
	_place_graph_node(graph_node, state)
	return graph_node


func _add_transitition(transitition: RSETransitition = null, state: Dictionary = {}) -> GraphTransitition:
	if transitition == null:
		transitition = story.add_transitition()
	var graph_node = GraphTransitition.new(transitition)
	_place_graph_node(graph_node, state)
	return graph_node


func _place_graph_node(graph: StoryGraph, state: Dictionary = {}) -> void:
	graph_edit.add_child(graph)
	graph.double_click.connect(start_edit_graph)
	if state.has(str(graph.id)):
		graph.size.x = state[str(graph.id)]["size_x"]
		graph.size.y = state[str(graph.id)]["size_y"]
		graph.position_offset.x = state[str(graph.id)]["position_x"]
		graph.position_offset.y = state[str(graph.id)]["position_y"]
	else:
		graph.position_offset = graph_edit.get_local_mouse_position() + graph_edit.scroll_offset / graph_edit.zoom


func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	for con in graph_edit.get_connection_list():
		if con.from_node == from_node and con.from_port == from_port:
			return
	#if from_node == to_node:
		#return
	graph_edit.connect_node(from_node, from_port, to_node, to_port)
	
	var from = graph_edit.get_node(String(from_node)) as StoryGraph
	var to = graph_edit.get_node(String(to_node)) as StoryGraph
	from.on_connect_to(to, from_port, to_port)
	to.on_connect_from(from, from_port, to_port)


func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	graph_edit.disconnect_node(from_node, from_port, to_node, to_port)
	
	var from = graph_edit.get_node(String(from_node)) as StoryGraph
	var to = graph_edit.get_node(String(to_node)) as StoryGraph
	from.on_disconnect_to(to, from_port, to_port)
	to.on_disconnect_from(from, from_port, to_port)


func _on_graph_edit_popup_request(position):
	if selected_nodes.size() > 0:
		edit_popup_menu.show()
		edit_popup_menu.position = get_screen_position() + get_local_mouse_position()
		if selected_nodes.size() > 1:
			edit_popup_menu.set_item_disabled(edit_popup_menu.get_item_index(0), true)
			edit_popup_menu.set_item_disabled(edit_popup_menu.get_item_index(3), false)
		else:
			if selected_nodes.has(start_node):
				edit_popup_menu.set_item_disabled(edit_popup_menu.get_item_index(0), true)
				edit_popup_menu.set_item_disabled(edit_popup_menu.get_item_index(2), true)
				edit_popup_menu.set_item_disabled(edit_popup_menu.get_item_index(3), true)
			else:
				edit_popup_menu.set_item_disabled(edit_popup_menu.get_item_index(0), false)
				edit_popup_menu.set_item_disabled(edit_popup_menu.get_item_index(2), false)
				edit_popup_menu.set_item_disabled(edit_popup_menu.get_item_index(3), false)
	else:
		add_popup_menu.show()
		add_popup_menu.position = get_screen_position() + get_local_mouse_position()


func _on_graph_edit_node_deselected(node):
	if selected_nodes.has(node):
		selected_nodes.erase(node)


func _on_graph_edit_node_selected(node):
	if not selected_nodes.has(node):
		selected_nodes.append(node)


func _on_edit_popup_menu_id_pressed(id):
	match id:
		0:
			## Редактирование.
			pass
		1:
			## Отсоединение.
			for node in selected_nodes:
				_remove_connections_to_node(node)
		2:
			## Дублирование.
			pass
		3:
			## Удаление.
			_on_graph_edit_delete_nodes_request(null)


func _on_add_popup_menu_id_pressed(id):
	match id:
		0:
			_add_episode()
		1:
			_add_character()
		2:
			_add_location()
		3:
			_add_visual_effect()
		4:
			_add_sound_effect()
		5:
			_add_music()
		6:
			_add_transitition()


func _on_graph_edit_delete_nodes_request(nodes):
	confimation_dialog.show()


func _on_confirmation_dialog_confirmed():
	for node: StoryGraph in selected_nodes:
		if node != start_node:
			_remove_connections_to_node(node)
			node.delete()
	selected_nodes.clear()


func _remove_connections_to_node(node: GraphNode) -> void:
	for con in graph_edit.get_connection_list():
		if con.to_node == node.name or con.from_node == node.name:
			graph_edit.disconnect_node(con.from_node, con.from_port, con.to_node, con.to_port)
			var from = graph_edit.get_node(String(con.from_node)) as StoryGraph
			var to = graph_edit.get_node(String(con.to_node)) as StoryGraph
			from.on_disconnect_to(to, con.from_port, con.to_port)
			to.on_disconnect_from(from, con.from_port, con.to_port)


func get_graph_state() -> Dictionary:
	var state = {
		"scroll_offset_x" : graph_edit.scroll_offset.x,
		"scroll_offset_y" : graph_edit.scroll_offset.y,
		"show_grid" : graph_edit.show_grid,
		"snapping_enabled" : graph_edit.snapping_enabled,
		"zoom" : graph_edit.zoom,
	}
	for graph: StoryGraph in graph_edit.get_children():
		state[str(graph.id)] = {
			"size_x" : graph.size.x,
			"size_y" : graph.size.y,
			"position_x" : graph.position_offset.x,
			"position_y" : graph.position_offset.y,
		}
	return state


func load_story(s: RSEStory) -> void:
	_clear_graph()
	
	story = s
	
	story_title_edit.text = s.name
	
	if s.graph_state.is_empty():
		_add_start()
		return
	
	_add_start(s.graph_state)
	
	var episode_graph_nodes: Dictionary
	for episode: RSEEpisode in s.episodes.values():
		episode.get_exits()
		var graph_node = _add_episode(episode, s.graph_state)
		episode_graph_nodes[episode.id] = graph_node
	
	connect_episode_graph_nodes(episode_graph_nodes)
	
	for character: RSECharacter in s.characters.values():
		var graph_node = _add_character(character, s.graph_state)
		if character.active:
			graph_edit.connect_node(graph_node.name, 0, start_node.name, start_node.character_port)
	
	for location: RSELocation in s.locations.values():
		var graph_node = _add_location(location, s.graph_state)
		if location.active:
			graph_edit.connect_node(graph_node.name, 0, start_node.name, start_node.location_port)
	
	for visual_effect: RSEVisualEffect in s.visual_effects.values():
		var graph_node = _add_visual_effect(visual_effect, s.graph_state)
		if visual_effect.active:
			graph_edit.connect_node(graph_node.name, 0, start_node.name, start_node.visual_effect_port)
	
	for sound_effect: RSESoundEffect in s.sound_effects.values():
		var graph_node = _add_sound_effect(sound_effect, s.graph_state)
		if sound_effect.active:
			graph_edit.connect_node(graph_node.name, 0, start_node.name, start_node.sound_effect_port)
	
	for music: RSEMusic in s.music_list.values():
		var graph_node = _add_music(music, s.graph_state)
		if music.active:
			graph_edit.connect_node(graph_node.name, 0, start_node.name, start_node.music_port)
	
	for transitition: RSETransitition in s.transititions.values():
		var graph_node = _add_transitition(transitition, s.graph_state)
		if transitition.active:
			graph_edit.connect_node(graph_node.name, 0, start_node.name, start_node.transitition_port)
	
	graph_edit.zoom = s.graph_state["zoom"]
	graph_edit.scroll_offset.x = s.graph_state["scroll_offset_x"]
	graph_edit.scroll_offset.y = s.graph_state["scroll_offset_y"]
	graph_edit.show_grid = s.graph_state["show_grid"]
	graph_edit.snapping_enabled = s.graph_state["snapping_enabled"]


func _clear_graph() -> void:
	selected_nodes.clear()
	for child in graph_edit.get_children():
		child.queue_free()
	graph_edit.clear_connections()


func _on_story_title_changed(new_text: String) -> void:
	story.name = new_text


func connect_episode_graph_nodes(episode_graph_nodes: Dictionary) -> void:
	for episode_graph: GraphEpisode in episode_graph_nodes.values():
		if episode_graph.episode.start:
			graph_edit.connect_node(start_node.name, start_node.story_output_port, episode_graph.name, episode_graph.input_port)
		var index := -1
		for exit in episode_graph.episode.exits:
			index += 1
			var id = exit["to_episode_id"]
			if episode_graph_nodes.has(int(id)):
				var next_graph = episode_graph_nodes[int(id)]
				graph_edit.connect_node(episode_graph.name, index, next_graph.name, next_graph.input_port)


func start_edit_graph(graph_node: StoryGraph) -> void:
	if graph_node is GraphEpisode:
		open_edit_episode.emit(graph_node.episode)
