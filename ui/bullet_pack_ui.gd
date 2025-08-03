class_name BulletPackUI
extends Button


signal hovered(pack: BulletPack)


var current_pack: BulletPack


func initialize(pack: BulletPack) -> void:
	current_pack = pack
	var bullet_sprite: TextureRect = %BulletSprite
	var name_label: Label = %NameLabel
	var count_label: Label = %CountLabel

	bullet_sprite.modulate = pack.bullet.color
	bullet_sprite.texture = pack.bullet.texture
	name_label.text = pack.bullet.name + "_name"
	count_label.text = "x" + str(pack.count)

func _on_mouse_entered() -> void:
	hovered.emit(current_pack)
