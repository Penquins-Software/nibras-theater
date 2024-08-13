extends RichTextLabel


func _ready():
	meta_clicked.connect(open_url)


func open_url(meta: Variant) -> void:
	UISoundManager.click()
	OS.shell_open(meta)
