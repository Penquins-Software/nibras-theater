extends TextureRect


@export var hands: Control
@export var image_ru: Texture2D
@export var image_en: Texture2D
@export var image_true_ru: Texture2D
@export var image_true_en: Texture2D


var true_ending: bool = false


func _ready():
	hands.visible = Settings.profile.global_variables.is_variable("ENDING_1") or Settings.profile.global_variables.is_variable("ENDING_2")
	true_ending = Settings.profile.global_variables.is_variable("TRUE_ENDING")
	_set_images()
	Settings.locale_was_changed.connect(_set_images)


func _set_images() -> void:
	if Settings.locale == "ru":
		if true_ending:
			texture = image_true_ru
		else:
			texture = image_ru
	else:
		if true_ending:
			texture = image_true_en
		else:
			texture = image_en
