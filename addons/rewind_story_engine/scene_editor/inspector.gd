@tool
class_name RSEInspector
extends Panel

signal node_changed()

@export var title: Label

@export var transform: Control
@export var position_x_spin_box: SpinBox
@export var position_y_spin_box: SpinBox
@export var rotation_spin_box: SpinBox
@export var rotation_slider: HSlider
@export var scale_spin_box: SpinBox
@export var flip_h_check_box: CheckBox
@export var order: Control
@export var order_spin_box: SpinBox
@export var character_preset: Control
@export var character_emotion: MenuButton
@export var character_outfit: MenuButton

var selected_node: Node2D


func _ready():
	character_emotion.get_popup().index_pressed.connect(_character_emotion_index_pressed)
	character_outfit.get_popup().index_pressed.connect(_character_outfit_index_pressed)


func set_node(node: Node2D) -> void:
	grab_focus()
	await get_tree().create_timer(0.02).timeout
	
	if is_instance_valid(selected_node):
		set_highlight_node(selected_node, false)
		if selected_node is RSEBaseController:
			selected_node.dragger.active = false
			selected_node.dragger.node_changed.disconnect(_set_parameters)
			selected_node.reseted.disconnect(_set_parameters)
	
	selected_node = node
	
	if node == null:
		title.text = ""
		transform.hide()
		character_preset.hide()
		return
	
	set_highlight_node(node, true)
	if selected_node is RSEBaseController:
		selected_node.dragger.active = true
		selected_node.dragger.node_changed.connect(_set_parameters)
		selected_node.reseted.connect(_set_parameters)
	
	title.text = node.to_string()
	transform.show()

	_set_parameters()


func set_highlight_node(node: Node, status: bool) -> void:
	if not is_instance_valid(node):
		return
	
	if node is RSEBaseCameraController:
		if node.border != null:
			node.border.set_highlight(status)
	
	if status:
		node.modulate = Color.GREEN_YELLOW
	else:
		node.modulate = Color.WHITE


func _set_parameters() -> void:
	position_x_spin_box.set_value_no_signal(selected_node.position.x)
	position_y_spin_box.set_value_no_signal(selected_node.position.y)
	rotation_spin_box.set_value_no_signal(selected_node.rotation_degrees)
	rotation_slider.set_value_no_signal(selected_node.rotation_degrees)
	scale_spin_box.set_value_no_signal(selected_node.scale.x)
	
	if selected_node.has_method("_set_flip_h"):
		flip_h_check_box.visible = true
		flip_h_check_box.button_pressed = selected_node.flip_h
	else:
		flip_h_check_box.visible = false
	
	if selected_node.has_method("_set_order"):
		order.visible = true
		order_spin_box.value = selected_node.order
	else:
		order.visible = false
	
	if selected_node is RSEBaseCharacterController:
		character_preset.show()
		
		character_emotion.text = "[Эмоция]"
		character_emotion.get_popup().clear()
		for emotion_id in selected_node.character.emotions:
			character_emotion.get_popup().add_item(selected_node.character.emotions[emotion_id], int(emotion_id))
			if selected_node._emotion_id == int(emotion_id):
				character_emotion.text = selected_node.character.emotions[emotion_id]
		
		character_outfit.text = "[Костюм]"
		character_outfit.get_popup().clear()
		for outfit_id in selected_node.character.outfits:
			character_outfit.get_popup().add_item(selected_node.character.outfits[outfit_id], int(outfit_id))
			if selected_node._outfit_id == int(outfit_id):
				character_outfit.text = selected_node.character.outfits[outfit_id]
	else:
		character_preset.hide()


func _on_position_x_changed(value):
	selected_node.position.x = value
	node_changed.emit()


func _on_position_y_changed(value):
	selected_node.position.y = value
	node_changed.emit()


func _on_rotation_changed(value):
	selected_node.rotation_degrees = value
	rotation_spin_box.set_value_no_signal(value)
	node_changed.emit()


func _on_rotation_spin_box_changed(value):
	selected_node.rotation_degrees = value
	rotation_slider.set_value_no_signal(value)
	node_changed.emit()


func _on_scale_changed(value):
	selected_node.scale = Vector2(value, value)
	if selected_node is RSEBaseCameraController:
		var zoom = 1 / value
		selected_node.camera.zoom = Vector2(zoom, zoom)
	node_changed.emit()


func _on_flip_h_check_box_toggled(toggled_on):
	selected_node.flip_h = toggled_on
	node_changed.emit()


func _on_order_changed(value):
	selected_node.order = value
	node_changed.emit()



func _character_emotion_index_pressed(index: int) -> void:
	var id = character_emotion.get_popup().get_item_id(index)
	character_emotion.text = character_emotion.get_popup().get_item_text(index)
	(selected_node as RSEBaseCharacterController).set_emotion(id)


func _character_outfit_index_pressed(index: int) -> void:
	var id = character_outfit.get_popup().get_item_id(index)
	character_outfit.text = character_outfit.get_popup().get_item_text(index)
	(selected_node as RSEBaseCharacterController).set_outfit(id)


func update() -> void:
	if is_instance_valid(selected_node):
		_set_parameters()
	else:
		set_node(null)
