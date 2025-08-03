class_name BulletManager
extends Node

signal added(index: int, bullet: BulletInfo)

var bullets: Array[BulletInfo]

func _ready() -> void:
	bullets = UserBarrels.current_barrel.bullets.duplicate(true)

func remove(index: int) -> void:
	bullets[index] = null

func add(bullet: BulletInfo, limit: int) -> void:
	var existing_count = bullets.count(bullet)
	if existing_count >= limit:
		return

	for i in range(bullets.size()):
		if bullets[i] == null:
			bullets[i] = bullet
			added.emit(i, bullet)
			return

func get_inserted_bullets(bullet: BulletInfo) -> int:
	return bullets.count(bullet)

func is_ready() -> bool:
	for i in range(bullets.size()):
		if not bullets[i]:
			return false
	return true
