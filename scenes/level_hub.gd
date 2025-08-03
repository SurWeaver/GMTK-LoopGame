extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var window = get_window()
	#window.mode = Window.MODE_FULLSCREEN
	pass


func _on_button_pressed() -> void:
	TransitionScreen.switch_to_scene(Resources.PATHS.level)
	pass # Replace with function body.
