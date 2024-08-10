@tool
class_name RSESceneEditor
extends Control


@export var scene_builder: RSESceneBuilder
@export var inspector: RSEInspector

@export var item_list: ItemList
@export var hierarchy_tree: Tree
@export var frame_spin_box: SpinBox


var story: RSEStory
var episode: RSEEpisode : set = _set_episode

var tree_nodes: Dictionary


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			inspector.set_node(null)
			hierarchy_tree.deselect_all()


func _set_episode(ep: RSEEpisode) -> void:
	scene_builder.save_scene_preset()
	episode = ep
	if ep != null:
		_set_preview()
		_build_hierarchy_tree()
		inspector.set_node(null)


func _build_hierarchy_tree() -> void:
	await get_tree().create_timer(0.02).timeout
	hierarchy_tree.clear()
	tree_nodes.clear()
	var root = _create_tree_item(scene_builder)
	for child in scene_builder.get_children():
		var item = _create_tree_item(child, root)
		if inspector.selected_node == child:
			hierarchy_tree.set_selected(item, 0)


func _create_tree_item(node: Node, parent: TreeItem = null) -> TreeItem:
	var item = hierarchy_tree.create_item()
	item.set_text(0, node.name)
	tree_nodes[item] = node
	return item
	# for child in node.get_children():
	# 	_create_tree_item(child, item)


func _set_preview() -> void:
	scene_builder.set_episode(episode)
	frame_spin_box.value = scene_builder.next_frame()


func load_story(s: RSEStory) -> void:
	story = s
	update_item_list()
	if story.episodes.size() > 0:
		episode = story.episodes.values()[0]
		item_list.select(0)
	else:
		episode = null


func update_item_list() -> void:
	item_list.clear()
	for episode: RSEEpisode in story.episodes.values():
		item_list.add_item(episode.get_id_with_name())


func _on_item_list_item_selected(index):
	episode = story.episodes.values()[index]


func _on_spin_box_value_changed(value: int):
	frame_spin_box.value = scene_builder.set_frame(value)
	_build_hierarchy_tree()
	inspector.update()


func _on_prev_pressed():
	frame_spin_box.set_value_no_signal(scene_builder.prev_frame())
	_build_hierarchy_tree()
	inspector.update()


func _on_next_pressed():
	frame_spin_box.set_value_no_signal(scene_builder.next_frame())
	_build_hierarchy_tree()
	inspector.update()


func _on_tree_item_selected():
	var item = hierarchy_tree.get_selected()
	inspector.set_node(tree_nodes[item])


func _on_inspector_node_changed():
	pass


func _on_inherit_prev_scene_preset_pressed():
	scene_builder.inherit_scene_preset_from_prev_frame()


func _on_inherit_next_scene_preset_pressed():
	scene_builder.inherit_scene_preset_from_next_frame()


func _on_reset_scene_preset_pressed():
	scene_builder.reset_scene_preset()
