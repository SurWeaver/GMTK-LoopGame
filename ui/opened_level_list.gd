extends VBoxContainer

signal requested_level(level_index: int)


func _ready() -> void:
	var unlocks = Levels.player_records.unlocks
	if unlocks.is_empty():
		load_levels_to(-1)
	else:
		var max_index = 0
		for unlock in unlocks:
			if unlock.level_index > max_index:
				max_index = unlock.level_index
		load_levels_to(max_index)

func load_levels_to(index: int) -> void:
	for level in Resources.LEVELS.levels:
		if level.level_index <= index + 1:
			var button = Button.new()
			button.text = level.description
			add_child(button)
			button.pressed.connect(go_to_level.bind(level.level_index))
func go_to_level(index: int) -> void:
	requested_level.emit(index)
