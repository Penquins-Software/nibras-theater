@tool
class_name Camera2DBorder
extends Node2D


const Colors = {
	true : Color.GREEN_YELLOW,
	false : Color.DARK_RED,
}

var lines: Array[Line2D]


func _init(camera2d: Camera2D):
	camera2d.add_child(self)
	
	var h_width = ProjectSettings.get_setting("display/window/size/viewport_width") / 2
	var h_height = ProjectSettings.get_setting("display/window/size/viewport_height") / 2
	
	_create_line(h_width, h_height)
	_create_line(h_height * 21 / 9, h_height)
	_create_line(h_height * 32 / 9, h_height)
	
	set_highlight(false)


func _create_line(h_width: float, h_height: float) -> void:
	var line = Line2D.new()
	
	add_child(line)
	
	line.closed = true
	
	line.add_point(Vector2(-h_width, -h_height))
	line.add_point(Vector2(h_width, -h_height))
	line.add_point(Vector2(h_width, h_height))
	line.add_point(Vector2(-h_width, h_height))
	
	line.z_index = 100
	line.width = 4
	
	lines.append(line)


func set_highlight(status: bool) -> void:
	for line in lines:
		line.default_color = Colors[status]
