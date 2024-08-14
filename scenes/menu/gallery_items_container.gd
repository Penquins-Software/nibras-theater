extends HFlowContainer


@export var image_preview: ImagePreview


func _ready():
	for child: GalleryItem in get_children():
		child.gallery_item.connect(image_preview.show_image)
