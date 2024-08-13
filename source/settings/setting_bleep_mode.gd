extends CheckBox


func _ready():
	button_pressed = Settings.bleep_mode


func _pressed():
	Settings.bleep_mode = button_pressed
