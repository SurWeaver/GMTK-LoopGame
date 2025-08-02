extends Node


const levels: LevelCollection = Resources.LEVELS

var player_records: PlayerLevelUnlockCollection

func _init() -> void:
	load_player_records()

func _exit_tree() -> void:
	save_player_records()

func load_player_records() -> void:
	if FileAccess.file_exists(Resources.PATHS.user_save):
		player_records = load(Resources.PATHS.user_save)

func save_player_records() -> void:
	ResourceSaver.save(player_records, Resources.PATHS.user_save)
