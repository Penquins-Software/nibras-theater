@tool
class_name RSEBaseTransititionController
extends Control


signal ended()


@export var player: AnimationPlayer
@export var animation_name: String

var transitition: RSETransitition


func play() -> void:
	z_index = 100
	player.play(animation_name)


func stop() -> void:
	player.stop()


func _on_animation_player_animation_finished(anim_name):
	ended.emit()
	await get_tree().create_timer(0.04).timeout
	queue_free()
