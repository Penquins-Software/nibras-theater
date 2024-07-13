@tool
class_name FrameEditor
extends Control

signal selected(frame: FrameEditor)
signal call_popup_menu()
signal dragging(frame: FrameEditor, value: bool)
signal under_pointer(frame: FrameEditor)
signal updated(frame: FrameEditor)

@export var highlight: ColorRect
@export var dragger: FrameDragger
@export var index_label: Label
@export var mouse_hook: MouseHook

var story: RSEStory
var frames_container: EpisodeEditorFramesContainer
var selected_menu_indicies: Dictionary
var index: int


func _ready():
	_base_setting()


func _base_setting() -> void:
	dragger.dragging.connect(_on_drag)
	mouse_entered.connect(_on_mouse_entered)


func _on_drag(value: bool) -> void:
	dragging.emit(self, value)


func _on_mouse_entered() -> void:
	under_pointer.emit(self)


func _gui_input(event):
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			select()
		if mouse_event.button_index == MOUSE_BUTTON_RIGHT and not mouse_event.is_released():
			select()
			call_popup_menu.emit()


func _gui_input_without_popup(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			select()


func _highlight() -> void:
	highlight.color = EditorInterface.get_base_control().get_theme_color("accent_color", "Editor") / 2
	highlight.show()


func select() -> void:
	_highlight()
	selected.emit(self)


func deselect() -> void:
	highlight.hide()


func set_index(i: int) -> void:
	index = i + 1
	index_label.text = str(index)


func _set_menu_button_index(index: int, menu_button: MenuButton, with_icon: bool) -> void:
	if index >= menu_button.get_popup().item_count:
		return
	selected_menu_indicies[menu_button] = index
	menu_button.text = menu_button.get_popup().get_item_text(index)
	if with_icon:
		menu_button.icon = menu_button.get_popup().get_item_icon(index)
	
	if is_visible_in_tree():
		await get_tree().create_timer(0.02).timeout
		updated.emit(self)


func get_frame() -> RSEFrame:
	return null


func setting(story: RSEStory, frame) -> void:
	self.story = story
	pass


func write_frame_info_to_scene_state(scene_state: EpisodeEditorSceneState) -> void:
	pass
