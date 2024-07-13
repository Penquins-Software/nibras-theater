class_name RSEFrameVisualEffect
extends RSEFrame


var effect_id: int = 0
var status: bool = false


func write_frame_info_to_scene_state(scene_state: RSESceneState) -> void:
	if status:
		if not scene_state.visual_effect_ids.has(effect_id):
			scene_state.visual_effect_ids.append(effect_id)
	else:
		if scene_state.visual_effect_ids.has(effect_id):
			scene_state.visual_effect_ids.erase(effect_id)


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.VisualEffect


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameVisualEffect",
		"effect_id" : effect_id,
		"status" : status,
	}
