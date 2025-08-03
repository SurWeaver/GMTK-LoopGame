extends Node2D

@export var spawner: Spawner

func _ready() -> void:
	spawner.level_finished.connect(_on_level_finish)

func _on_level_finish() -> void:

	pass


func _on_count_down_screen_started() -> void:
	spawner.start()
