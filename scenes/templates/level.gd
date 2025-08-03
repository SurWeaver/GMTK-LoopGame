extends Node2D

@onready var spawner: Spawner = $Spawner
@onready var timer_label: TimerLabel = %TimerLabel
@onready var point_label: PointLabel = %PointLabel
@onready var level_end_screen: LevelEndScreen = $Control/LevelEndScreen
@onready var aim: Node2D = $Aim


func _on_level_finish() -> void:
	var current_record = create_record()
	var record = Levels.get_current_level_record()
	if not record:
		Levels.add_record(current_record)
		level_end_screen.animate_show(current_record)
	else:
		record.least_time = min(record.least_time, current_record.least_time)
		record.max_point = max(record.max_point, current_record.max_point)
		level_end_screen.animate_show(record)

	aim.queue_free()


func create_record() -> PlayerLevelUnlock:
	var record = PlayerLevelUnlock.new()
	record.level_index = Levels.current_level_index
	record.max_point = point_label.points
	record.least_time = timer_label.passed_seconds
	return record

func _on_count_down_screen_started() -> void:
	spawner.start()
