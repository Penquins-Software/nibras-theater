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
	_update_text()
	
	Settings.locale_was_changed.connect(_update_text)


func _on_load_pressed():
	load_save.emit(_save)


func _on_delete_pressed():
	if _save == null:
		return
	delete_save.emit(self)


func _update_text() -> void:
	label.text = ""
	if _save.auto_save:
		label.text = "[color=INDIAN_RED][%s][/color] " % tr("АВТО")
	var datetime = "%s.%02d.%02d %02d:%02d:%02d" % [_save.datetime["year"], _save.datetime["month"], _save.datetime["day"], _save.datetime["hour"], _save.datetime["minute"], _save.datetime["second"]]
	label.text += "%s\n%s" % [tr(_save.episode_name), datetime]
