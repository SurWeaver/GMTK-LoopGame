class_name LevelHorde
extends Resource


@export var targets: Dictionary[int, PackedScene]
@export var waves: Array[LevelWave]

func get_target_new_scene(target_index: int) -> Target:
	return targets[target_index].instantiate()
