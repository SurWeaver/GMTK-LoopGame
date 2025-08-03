extends Node2D


const VISIBILITY_CHANGE_DURATION: float = 0.3


func _init() -> void:
	modulate = Color.TRANSPARENT

func switch_to_scene(scene_path: String) -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, VISIBILITY_CHANGE_DURATION)

	tween.tween_callback(get_tree().change_scene_to_file.bind(scene_path))
	tween.tween_property(self, "modulate", Color.TRANSPARENT, VISIBILITY_CHANGE_DURATION)
