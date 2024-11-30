extends MenuButton


var locales: PackedStringArray


func _ready():
	locales = _remove_duplicate_locales(TranslationServer.get_loaded_locales())
	
	if (locales.size() < 2):
		disabled = true
		return
	
	for locale in locales:
		get_popup().add_item(TranslationServer.get_locale_name(locale))
	
	text = TranslationServer.get_locale_name(Settings.locale)
	
	get_popup().index_pressed.connect(_set_language)


func _set_language(id: int):
	text = get_popup().get_item_text(id)
	Settings.locale = locales[id]


func _remove_duplicate_locales(all_locales: Array) -> Array:
	var unique: Array = []
	for locale in all_locales:
		if not unique.has(locale):
			unique.append(locale)
	return unique
