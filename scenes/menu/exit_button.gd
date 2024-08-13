extends Button


func _pressed():
	UISoundManager.click()
	get_tree().quit()
