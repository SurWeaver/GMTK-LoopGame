class_name Ammunition
extends Resource


@export var bullet_packs: Array[BulletPack]

func add(pack: BulletPack) -> void:
	for existing_pack in bullet_packs:
		if existing_pack.bullet == pack.bullet:
			existing_pack.count += pack.count
			return

	bullet_packs.append(pack)
