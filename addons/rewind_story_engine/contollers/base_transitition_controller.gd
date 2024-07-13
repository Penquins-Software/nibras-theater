@tool
class_name RSEBaseTransititionController
extends RSEBaseController


signal on_half()
signal ended()


@export var player: AnimationPlayer
@export var animation_name: String

var transitition: RSETransitition

var from_end: bool = false


func play() -> void:
	player.play(animation_name)


func stop() -> void:
	player.stop()


func _on_animation_player_animation_finished(anim_name):
	if not from_end:
		from_end = true
		player.play_backwards(animation_name)
	
