extends Node

const USER_BARREL_COUNT = 3

var barrels: Array[BarrelInfo]

var selected_barrel: BarrelInfo


func _init() -> void:
	barrels = []
	for i in range(USER_BARREL_COUNT):
		barrels.append(Resources.TEMPLATES.default_barrel.duplicate(true))

	selected_barrel = Resources.TEMPLATES.default_barrel.duplicate(true)
