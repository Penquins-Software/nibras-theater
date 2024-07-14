extends LineEdit


func _ready():
	text = Settings.player_name


func _on_text_changed(new_text):
	Settings.player_name = new_text
