class_name BarrelInfo
extends Resource


@export var bullets: Array[BulletInfo]


func get_enumerator() -> BarrelEnumerator:
	return BarrelEnumerator.new(bullets)
