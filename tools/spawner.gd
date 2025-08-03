class_name Spawner
extends Node

signal level_finished

@export var level_horde: LevelHorde

@export var target_places: Dictionary[int, TargetPlaceDispenser]

var current_wave: LevelWave
var current_enemy_count: int = 0

var index: int = 0

func start() -> void:
	current_wave = level_horde.waves[0]
	spawn_wave(current_wave)

func spawn_wave(wave: LevelWave) -> void:
	for pack in wave.packs:
		current_enemy_count += pack.amount
		var dispenser = target_places[pack.distance]
		var free_places = dispenser.get_shuffled_free_places(pack.amount)
		for i in range(pack.amount):
			var enemy = level_horde.get_target_new_scene(pack.enemy_index)
			free_places[i].add_child(enemy)
			enemy.died.connect(count_down_enemy)

func count_down_enemy() -> void:
	current_enemy_count -= 1
	if current_enemy_count == 0:
		spawn_new_wave()

func spawn_new_wave() -> void:
	index += 1
	if index >= level_horde.waves.size():
		level_finished.emit()
		return

	await get_tree().create_timer(current_wave.delay_seconds_before_next).timeout

	current_wave = level_horde.waves[index]
	spawn_wave(current_wave)
