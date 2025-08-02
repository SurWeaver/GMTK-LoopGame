class_name BarrelEnumerator
extends RefCounted

var _bullets: Array[BulletInfo]
var _index: int = 0

func _init(bullets: Array[BulletInfo]) -> void:
	_bullets = bullets

func next() -> void:
	_index = (_index + 1) % 6

func current() -> BulletInfo:
	return _bullets[_index]

func get_neighboring(delta_index: int) -> BulletInfo:
	return _bullets[posmod(delta_index + _index, 6)]

func reset() -> void:
	_index = 0
