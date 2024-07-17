extends MenuElement


signal load_save(save: Save)

const SaveContainerScene: PackedScene = preload("res://scenes/save_manager/save_container.tscn")

@export var saves_container: Control
@export var confirmation_dialog: ConfirmationDialog


var save_to_delete: SaveContainer


func _enter_tree():
	SaveManager.saves_loaded.connect(set_saves)
	set_saves()


func _exit_tree():
	SaveManager.saves_loaded.disconnect(set_saves)


func clear_saves() -> void:
	for child in saves_container.get_children():
		child.queue_free()


func set_saves() -> void:
	clear_saves()
	for save in SaveManager.saves:
		var save_container = SaveContainerScene.instantiate() as SaveContainer
		save_container.set_save(save)
		save_container.load_save.connect(_on_load_save)
		save_container.delete_save.connect(_on_delete_save)
		saves_container.add_child(save_container)
		saves_container.move_child(save_container, 0)


func _on_load_save(save: Save) -> void:
	hide()
	load_save.emit(save)


func _on_delete_save(save_container: SaveContainer) -> void:
	save_to_delete = save_container
	confirmation_dialog.show()


func _on_confirmation_dialog_confirmed():
	save_to_delete._save.delete()
	save_to_delete.queue_free()
