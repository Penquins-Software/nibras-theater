class_name VariablesStorage
extends RefCounted


var data: Dictionary


func add_variable(variable_name: String, value = null) -> void:
	if value != null:
		data[variable_name] = value
	else:
		if not data.has("Flags"):
			data["Flags"] = []
		if not data["Flags"].has(variable_name):
			data["Flags"].append(variable_name)


func remove_variable(variable_name: String, _value = null) -> void:
	if data.has(variable_name):
		data.erase(variable_name)
	elif data.has("Flags") and data["Flags"].has(variable_name):
		data["Flags"].erase(variable_name)


func is_variable(variable_name: String, value = null) -> bool:
	if not data.has(variable_name):
		return false
	
	if value == null:
		return true
	
	return data[variable_name] == value
