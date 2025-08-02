class_name BulletInfo
extends Resource

#enum Effect { }

#@export var effects: Array[Effect]

@export var texture: Texture2D
@export var color: Color = Color.WHITE

@export var recoil_angle: float = 5
@export var recoil_speed: float = 4
@export var recoil_duration: float = 0.1

@export var damage: float = 1

@export var distance_damage_multiplier: float = 0

@export var aim_radius: float = 5
