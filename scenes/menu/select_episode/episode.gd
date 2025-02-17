class_name Episode
extends TextureRect


@export var select_episode: SelectEpisode
@export var episode_id: int
@export var condition: String
@export var idle_image: Texture
@export var hide_image: Texture
@export var area: Area2D
@export var label: Label
@export var bywho: Label
@export var animation_player: AnimationPlayer


var unlocked: bool = true
var active: bool = false
var original_text: String


func _ready():
	original_text = label.text
	
	if condition == "":
		return
	
	if not Settings.profile.global_variables.is_variable(condition):
		texture = hide_image
		unlocked = false
		#queue_free()
		return


func _gui_input(event):
	if not active or not unlocked:
		return
	
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_released():
			_start_episode()


func _on_area_2d_mouse_entered():
	if not unlocked:
		return
	
	active = true
	if animation_player != null:
		animation_player.play("show")
	if label != null:
		label.show()
		label.text = _get_localized_text_with_quotes()
	if bywho != null:
		bywho.show()


func _on_area_2d_mouse_exited():
	if not unlocked:
		return
	
	active = false
	if animation_player != null:
		animation_player.play("RESET")
	if label != null:
		label.hide()
	if bywho != null:
		bywho.hide()


func _start_episode() -> void:
	if select_episode.menu == null:
		return
	
	UISoundManager.click()
	var save = Save.new(null, episode_id, 0, {})
	select_episode.menu.load_game(save)


func is_viewed() -> bool:
	return Settings.profile.is_viewed_episode(episode_id)


func _get_localized_text_with_quotes() -> String:
	var translated_text = tr(original_text)
	
	if not translated_text.begins_with('"'):
		translated_text = '"' + translated_text
	if not translated_text.ends_with('"'):
		translated_text = translated_text + '"'
	
	return translated_text
