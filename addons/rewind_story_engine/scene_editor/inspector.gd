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

var selected_node: Node2D


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
