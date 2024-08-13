extends TextureRect


@export var border: Control


func _ready():
	if border != null:
		mouse_entered.connect(border.show)
		mouse_exited.connect(border.hide)
