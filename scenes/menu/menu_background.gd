extends TextureRect


@export var hands: Control
@export var true_ending: Texture2D


func _ready():
	hands.visible = Settings.profile.global_variables.is_variable("ENDING_1") or Settings.profile.global_variables.is_variable("ENDING_2")
	if Settings.profile.global_variables.is_variable("TRUE_ENDING"):
		texture = true_ending
