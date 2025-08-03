class_name RevolverBullet
extends Control


@onready var bullet_color_fill: TextureRect = %BulletColorFill
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_showing: bool = false

func initialize(bullet_info: BulletInfo) -> void:
	bullet_color_fill.modulate = bullet_info.color

func animate_show() -> void:
	if is_showing:
		animation_player.play("show_tip")

func animate_hide() -> void:
	if is_showing:
		animation_player.play("hide_tip")

func animate_insert() -> void:
	if is_showing:
		return

	animation_player.play("insert")
	is_showing = true

func animate_remove() -> void:
	if not is_showing:
		return

	animation_player.play("remove")
	is_showing = false
