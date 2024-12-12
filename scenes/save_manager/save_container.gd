class_name SaveContainer
extends HBoxContainer


signal load_save(save: Save)
signal delete_save(save_container: SaveContainer)


@export var image: TextureRect
@export var label: RichTextLabel


var _save: Save


func set_save(save: Save) -> void:
	_save = save
	if save.image != null:
		image.texture = ImageTexture.create_from_image(save.image)
	var datetime = "%s.%02d.%02d %02d:%02d:%02d" % [save.datetime["year"], save.datetime["month"], save.datetime["day"], save.datetime["hour"], save.datetime["minute"], save.datetime["second"]]
	label.text = ""
	if save.auto_save:
		label.text = "[color=INDIAN_RED][АВТО][/color] "
	label.text += "%s\n%s" % [tr(save.episode_name), datetime]


func _on_load_pressed():
	load_save.emit(_save)


func _on_delete_pressed():
	if _save == null:
		return
	delete_save.emit(self)
