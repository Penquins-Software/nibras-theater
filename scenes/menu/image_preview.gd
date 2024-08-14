extends Control


@export var image_rect: TextureRect
@export var description_label: Label


func show_image(image: Texture2D, description: String) -> void:
	show()
	image_rect.texture = image
	description_label.text = description


func _on_exit_pressed():
	hide()
