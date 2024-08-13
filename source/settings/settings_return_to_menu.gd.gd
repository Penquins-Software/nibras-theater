extends ButtonWithSound


func _ready():
	pressed.connect(Settings.save_config)
