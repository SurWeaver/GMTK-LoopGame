class_name LevelInfo
extends Resource


@export var level_index: int
@export var level_horde: LevelHorde
@export var description: String

@export_group("Rewards")
@export var time_limit: float
@export var time_limit_reward: BulletPack

@export var point_limit: int
@export var point_limit_reward: BulletPack
