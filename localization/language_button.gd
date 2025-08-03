extends TextureButton

var current_locale_code: String

func _ready() -> void:
	var current_locale = TranslationServer.get_locale()
	for locale in TranslationServer.get_loaded_locales():
		if current_locale.begins_with(locale):
			current_locale_code = locale

func _on_pressed() -> void:
	current_locale_code = "en" if current_locale_code == "ru" else "ru"
	TranslationServer.set_locale(current_locale_code)
