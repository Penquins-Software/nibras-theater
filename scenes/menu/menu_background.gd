extends TextureRect


@export var image_2: Texture2D
@export var image_3: Texture2D


func _ready():
	if Settings.profile.global_variables.is_variable("TRUE_ENDING"):
		texture = image_3
	elif Settings.profile.global_variables.is_variable("ENDING_1") or Settings.profile.global_variables.is_variable("ENDING_2"):
		texture = image_2
