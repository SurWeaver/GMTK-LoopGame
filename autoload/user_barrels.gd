extends Node

const USER_BARREL_COUNT = 3

var barrels: Array[BarrelInfo]

var current_barrel: BarrelInfo


func _init() -> void:
	load_barrels()

func load_barrels() -> void:
	if FileAccess.file_exists(Resources.PATHS.user_barrels):
		var user_barrel_collection: BarrelCollection = load(Resources.PATHS.user_barrels)
		barrels = user_barrel_collection.barrels.duplicate(true)
		current_barrel = barrels[0].duplicate(true)
		return

	barrels = []
	for i in range(USER_BARREL_COUNT):
		barrels.append(Resources.TEMPLATES.default_barrel.duplicate(true))

	current_barrel = Resources.TEMPLATES.default_barrel.duplicate(true)

func _exit_tree() -> void:
	var barrel_collection = BarrelCollection.new()
	barrel_collection.barrels = barrels
	ResourceSaver.save(barrel_collection, Resources.PATHS.user_barrels)
