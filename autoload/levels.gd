extends Node


const levels: LevelCollection = Resources.LEVELS

var player_records: PlayerLevelUnlockCollection
var current_level_index: int = 0

func _init() -> void:
	load_player_records()

func _exit_tree() -> void:
	save_player_records()

func load_player_records() -> void:
	if FileAccess.file_exists(Resources.PATHS.user_save):
		player_records = load(Resources.PATHS.user_save)
	else:
		player_records = PlayerLevelUnlockCollection.new()
		player_records.unlocks = []

func save_player_records() -> void:
	ResourceSaver.save(player_records, Resources.PATHS.user_save)


func get_current_level_record() -> PlayerLevelUnlock:
	return get_player_record(current_level_index)

func get_player_record(level_index: int) -> PlayerLevelUnlock:
	for unlock in player_records.unlocks:
		if unlock.level_index == level_index:
			return unlock
	return null

func add_record(record: PlayerLevelUnlock) -> void:
	player_records.unlocks.append(record)
