class_name LevelEndScreen
extends Control

func _ready() -> void:
	hide()

func animate_show(best_record: PlayerLevelUnlock) -> void:
	show()
	var current_level = Resources.LEVELS.levels[Levels.current_level_index]

	current_level.point_limit
	%NeededTimeLabel.text = "%d %s" % [current_level.time_limit, tr("seconds_suffix")]
	%RecordTimeLabel.text = "%d %s" % [best_record.least_time, tr("seconds_suffix")]

	%NeededPointsLabel.text = "%d %s" % [current_level.point_limit, tr("points_suffix")]
	%RecordPointsLabel.text = "%d %s" % [best_record.max_point, tr("points_suffix")]

	if best_record.least_time <= current_level.time_limit:
		add_reward(current_level.time_limit_reward)
	if best_record.max_point >= current_level.point_limit:
		add_reward(current_level.point_limit_reward)


func add_reward(pack: BulletPack) -> void:
	var pack_ui = Resources.TEMPLATES.bullet_pack_ui.instantiate()
	pack_ui.initialize(pack)
	%Packs.add_child(pack_ui)


func _on_button_pressed() -> void:
	TransitionScreen.switch_to_scene(Resources.PATHS.hub)
