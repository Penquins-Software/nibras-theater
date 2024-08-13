extends ButtonWithSound


func _ready():
	if SaveManager.saves.size() == 0:
		disabled = true
