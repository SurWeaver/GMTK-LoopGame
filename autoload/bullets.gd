extends Node



var current_opened_bullets: Array[BulletInfo]

var ammunition: Ammunition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_ammunition()

func update_ammunition() -> void:
	initialize_ammunition()
	load_opened_bullets()

func initialize_ammunition() -> void:
	ammunition = Ammunition.new()
	var default_bullet_pack = BulletPack.new()
	default_bullet_pack.bullet = Resources.TEMPLATES.default_bullet
	default_bullet_pack.count = 6
	ammunition.add(default_bullet_pack)

func load_opened_bullets() -> void:
	var player_records = Levels.player_records.unlocks
	for record in player_records:
		var level_info = get_level_info(record.level_index)
		if record.least_time <= level_info.time_limit:
			ammunition.add(level_info.time_limit_reward)
		if record.max_point >= level_info.point_limit:
			ammunition.add(level_info.point_limit_reward)


func get_level_info(index: int) -> LevelInfo:
	var levels = Resources.LEVELS.levels
	for level in levels:
		if level.level_index == index:
			return level
	return null
