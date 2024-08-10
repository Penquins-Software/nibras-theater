class_name RSEScenePreset
extends RefCounted


var camera_transform: Dictionary
var location_transform: Dictionary
var character_transforms: Dictionary
var visual_effects_transforms: Dictionary


func save_to_dictionary() -> Dictionary:
	var data := {
		"camera_transform" : camera_transform,
		"location_transform" : location_transform,
		"character_transforms" : character_transforms,
		"visual_effects_transforms" : visual_effects_transforms,
	}

	return data


static func load_from_dictionary(data: Dictionary) -> RSEScenePreset:
	var scene_preset = RSEScenePreset.new()
	
	scene_preset.camera_transform = data["camera_transform"]
	scene_preset.location_transform = data["location_transform"]
	scene_preset.character_transforms = data["character_transforms"]
	scene_preset.visual_effects_transforms = data["visual_effects_transforms"]

	return scene_preset


func add_camera_preset(camera_controller: RSEBaseCameraController) -> void:
	camera_transform = {
		"position_x": camera_controller.position.x,
		"position_y": camera_controller.position.y,
		"rotation": camera_controller.rotation_degrees,
		"scale": camera_controller.scale.x,
		"zoom": camera_controller.camera.zoom.x,
	}


func apply_preset_to_camera(camera_controller: RSEBaseCameraController) -> void:
	if camera_transform.is_empty():
		return
	
	camera_controller.position.x = camera_transform["position_x"]
	camera_controller.position.y = camera_transform["position_y"]
	camera_controller.rotation = camera_transform["rotation"]
	camera_controller.scale = Vector2(camera_transform["scale"], camera_transform["scale"])
	camera_controller.camera.zoom = Vector2(camera_transform["zoom"], camera_transform["zoom"])


func add_location_preset(location_controller: RSEBaseLocationController) -> void:
	location_transform = {
		"position_x": location_controller.position.x,
		"position_y": location_controller.position.y,
		"rotation": location_controller.rotation_degrees,
		"scale": location_controller.scale.x,
	}


func apply_preset_to_location(location_controller: RSEBaseLocationController) -> void:
	if location_transform.is_empty():
		return
	
	location_controller.position.x = location_transform["position_x"]
	location_controller.position.y = location_transform["position_y"]
	location_controller.rotation_degrees = location_transform["rotation"]
	location_controller.scale = Vector2(location_transform["scale"], location_transform["scale"])


func add_character_preset(character_controller: RSEBaseCharacterController) -> void:
	character_transforms[str(character_controller.character.id)] = {
		"id": character_controller.character.id,
		"position_x": character_controller.position.x,
		"position_y": character_controller.position.y,
		"rotation": character_controller.rotation_degrees,
		"scale": character_controller.scale.x,
		"flip_h": character_controller.flip_h,
		"order": character_controller.order,
		"emotion_id": character_controller._emotion_id,
		"outfit_id": character_controller._outfit_id,
	}


func apply_preset_to_character(character_controller: RSEBaseCharacterController) -> bool:
	if not character_transforms.has(str(character_controller.character.id)):
		return false
	
	var transform: Dictionary = character_transforms[str(character_controller.character.id)]
	
	character_controller.position.x = transform["position_x"]
	character_controller.position.y = transform["position_y"]
	character_controller.rotation_degrees = transform["rotation"]
	character_controller.scale = Vector2(transform["scale"], transform["scale"])
	character_controller.flip_h = transform["flip_h"]
	character_controller.order = transform["order"]
	if transform.has("emotion_id"):
		character_controller.set_emotion(transform["emotion_id"])
	if transform.has("outfit_id"):
		character_controller.set_outfit(transform["outfit_id"])

	return true


func add_visual_effect_preset(visual_effect_controller: RSEBaseVisualEffectController) -> void:
	visual_effects_transforms[str(visual_effect_controller.visual_effect.id)] = {
		"id": visual_effect_controller.visual_effect.id,
		"position_x": visual_effect_controller.position.x,
		"position_y": visual_effect_controller.position.y,
		"rotation": visual_effect_controller.rotation_degrees,
		"scale": visual_effect_controller.scale.x,
	}


func apply_preset_to_visual_effect(visual_effect_controller: RSEBaseVisualEffectController) -> bool:
	if not visual_effects_transforms.has(str(visual_effect_controller.visual_effect.id)):
		return false
	
	var transform: Dictionary = visual_effects_transforms[str(visual_effect_controller.visual_effect.id)]
	
	visual_effect_controller.position.x = transform["position_x"]
	visual_effect_controller.position.y = transform["position_y"]
	visual_effect_controller.rotation_degrees = transform["rotation"]
	visual_effect_controller.scale = Vector2(transform["scale"], transform["scale"])

	return true
