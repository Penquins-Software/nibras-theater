class_name GalleryItem
extends Control


signal gallery_item(image: Texture2D, description: String)


@export var id: int = 0
@export var condition: String
@export_multiline var tip_for_unlock: String = "Закрыто!"
@export_multiline var description: String = ""
@export var tip_label: Label
@export var image: Texture2D
@export var image_rect: TextureRect
@export var border: TextureRect
@export var lock: Control
@export var new_label: Control

var viewed: bool = false
var locked: bool = true
var new: bool = true


func _ready():
	if image == null:
		queue_free()
	
	image_rect.texture = image
	update_tip_text()
	
	viewed = Settings.profile.viewed_gallery_images.has(float(id))
	
	if condition == "" or Settings.profile.global_variables.is_variable(condition):
		lock.visible = false
		locked = false
	
	new = not locked and not viewed
	if not new:
		new_label.visible = false


func update_tip_text() -> void:
	tip_label.text = tr(tip_for_unlock)


func _on_image_mouse_entered():
	if lock.visible:
		return
	border.visible = true


func _on_image_mouse_exited():
	if lock.visible:
		return
	border.visible = false


func _on_image_gui_input(event):
	if lock.visible:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			UISoundManager.click()
			gallery_item.emit(image, description)
			if new:
				Settings.profile.add_image_to_viewed(id)
				new = false
				new_label.visible = false
