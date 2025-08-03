class_name LevelInfo
extends Resource


@export var level_horde: LevelHorde
@export var description: String
@export var unlocked: bool = false

@export_group("Rewards")
@export var time_limit: float
@export var time_limit_reward: BulletInfo

## Выдаваемое количество пуль
@export var time_bullet_count: int = 1

@export var point_limit: int
@export var point_limit_reward: BulletInfo

## Выдаваемое количество пуль
@export var point_limit_count: int = 1
