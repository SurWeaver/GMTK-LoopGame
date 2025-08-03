extends Node


const TEMPLATES = {
	"default_barrel": preload("res://data/barrels/default_barrel.tres"),
	"default_bullet": preload("res://data/bullets/standard_bullet.tres"),
	"damage_number": preload("res://assets/ui/damage_number.tscn"),
	"bullet_pack_ui": preload("res://ui/bullet_pack_ui.tscn"),
}

const LEVELS: LevelCollection = preload("res://data/levels/levels.tres")

const PATHS = {
	"user_save": "user://save.res",
	"user_barrels": "user://barrels.res",
	"level": "res://scenes/templates/level.tscn",
	"hub": "res://scenes/level_hub.tscn",
}
