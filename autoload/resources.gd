extends Node


const TEMPLATES = {
	"default_barrel": preload("res://data/barrels/default_barrel.tres"),
	"damage_number": preload("res://assets/ui/damage_number.tscn"),
}

const LEVELS: LevelCollection = preload("res://data/levels/levels.tres")

const PATHS = {
	"user_save": "user://save.res",
	"user_barrels": "user://barrels.res",
	"level": "res://scenes/templates/level.tscn",
	"hub": "res://scenes/level_hub.tscn",
}
