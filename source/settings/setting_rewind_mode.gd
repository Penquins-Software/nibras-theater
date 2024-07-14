extends MenuButton


func _ready():
	text = get_popup().get_item_text(get_popup().get_item_index(Settings.rewind_mode))
	get_popup().index_pressed.connect(_set_rewind_mode)


func _set_rewind_mode(index: int) -> void:
	Settings.rewind_mode = get_popup().get_item_id(index) as Settings.RewindMode
	text = get_popup().get_item_text(index);
