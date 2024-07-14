@tool
class_name RSEBaseTransititionController
extends RSEBaseController


signal ended()


@export var player: AnimationPlayer
@export var animation_name: String

var transitition: RSETransitition


func play() -> void:
	player.play(animation_name)


func stop() -> void:
	player.stop()


func _on_animation_player_animation_finished(anim_name):
	ended.emit()
