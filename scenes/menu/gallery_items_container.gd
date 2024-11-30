@tool
extends HFlowContainer


@export var image_preview: ImagePreview


func _ready():
	#generate_pot("res://translation//gallery.pot")
	for child: GalleryItem in get_children():
		child.gallery_item.connect(image_preview.show_image)


func _notification(what):
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		for child: GalleryItem in get_children():
			child.update_tip_text()


func generate_pot(path: String) -> void:
	var pot: String = 'msgid ""\nmsgstr ""\n\n'
		
	var keys: PackedStringArray = []
	
	for child in get_children():
		if child is GalleryItem:
			pot = try_add_string(keys, pot, child.tip_for_unlock)
			pot = try_add_string(keys, pot, child.description)
	
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(pot)
	file.close()


func try_add_string(keys: PackedStringArray, pot: String, str: String) -> String:
	if not keys.has(str):
		keys.append(str)
		pot += get_pot_string(str)
	return pot


func get_pot_string(text: String) -> String:
	return 'msgid "%s"\nmsgstr "%s"\n\n' % [text, ""] 
