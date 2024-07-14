extends Node


@export var slider: HSlider
@export var spin_box: SpinBox


func _ready():
	slider.value = Settings.text_speed
	spin_box.value = Settings.text_speed
	
	slider.min_value = Settings.MIN_TEXT_SPEED
	spin_box.min_value = Settings.MIN_TEXT_SPEED
	slider.max_value = Settings.MAX_TEXT_SPEED
	spin_box.max_value = Settings.MAX_TEXT_SPEED
	
	slider.value_changed.connect(_slider_value_changed)
	spin_box.value_changed.connect(_spin_box_value_changed)


func _slider_value_changed(value: float):
	spin_box.value = slider.value;
	Settings.text_speed = int(value)


func _spin_box_value_changed(value: float):
	slider.value = spin_box.value
