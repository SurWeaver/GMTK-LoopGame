class_name RevolverBullet
extends Control


@onready var bullet_color_fill: TextureRect = %BulletColorFill
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _bullet_is_visible: bool = true

func initialize(bullet_info: BulletInfo) -> void:
	bullet_color_fill.modulate = bullet_info.color

func animate_show() -> void:
	if _bullet_is_visible:
		animation_player.play("show_tip")

func animate_hide() -> void:
	if _bullet_is_visible:
		animation_player.play("hide_tip")

func animate_insert() -> void:
	if _bullet_is_visible:
		return

	animation_player.play("insert")
	_bullet_is_visible = true

func animate_remove() -> void:
	if not _bullet_is_visible:
		return

	animation_player.play("remove")
	_bullet_is_visible = false
