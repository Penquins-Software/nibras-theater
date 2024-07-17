class_name RSEFrameVariable
extends RSEFrame


var global: bool = false
var name: String = ""
var value


func _init():
	real_frame = true


func write_frame_info_to_scene_state(scene_state: RSESceneState) -> void:
	scene_state.variables[name] = value


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Variable


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameVariable",
		"name" : name,
		"value" : value,
		"global" : global,
	}


func print_info() -> void:
	print_rich("[i][color=CHARTREUSE]Переменная: %s = %s" % [name, value])
