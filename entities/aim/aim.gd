extends Node2D

signal earned_points(points: int)

const BULLET_ANGLE: float = deg_to_rad(60)



enum State {
	AIM,
	RECOIL,
}

var barrel: BarrelInfo

var enabled: bool = false

@export var damage_number_layer: CanvasItem

@onready var bullets_transform_node: Node2D = %Bullets
@onready var target_tracker: TargetTracker = $TargetTracker
@onready var shoot_player: AudioStreamPlayer = $AudioStreamPlayer

var bullets: BarrelEnumerator

var current_state: State = State.AIM

var viewport: Viewport

var aim_shape: CircleShape2D
var last_recoil_direction: Vector2
var last_correct_barrel_angle: float

func _enter_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func enable() -> void:
	enabled = true
func disable() -> void:
	enabled = false

func _ready() -> void:
	last_correct_barrel_angle = bullets_transform_node.rotation
	barrel = UserBarrels.current_barrel
	bullets = barrel.get_enumerator()
	aim_shape = %AimShape.shape as CircleShape2D
	aim_shape.radius = bullets.current().aim_radius
	initialize_look(bullets)

	bullets.reset()

	viewport = get_viewport()

@warning_ignore("shadowed_variable")
func initialize_look(bullets: BarrelEnumerator) -> void:
	for bullet_sprite in %BulletSprites.get_children():
		var current_bullet = bullets.current()
		bullet_sprite.texture = current_bullet.texture
		bullet_sprite.modulate = current_bullet.color
		bullets.next()


func _process(_delta: float) -> void:
	position = viewport.get_mouse_position()
	if current_state == State.AIM:
		process_shoot()

func process_shoot() -> void:
	if Input.is_action_just_pressed("shoot") and enabled:
		current_state = State.RECOIL
		animate_recoil()
		animate_bullet_switch()
		shoot()

		bullets.next()
		aim_shape.radius = bullets.current().aim_radius

func animate_recoil() -> void:
	var current_bullet = bullets.current()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	var angle_error = Random.get_float(-current_bullet.recoil_angle, current_bullet.recoil_angle)
	last_recoil_direction = Vector2.from_angle(Vector2.UP.angle() + deg_to_rad(angle_error))

	tween.tween_method(recoil, current_bullet.recoil_speed, 0, current_bullet.recoil_duration)

func recoil(amount: float) -> void:
	var current_position: Vector2 = viewport.get_mouse_position()
	var delta = last_recoil_direction * amount

	viewport.warp_mouse(current_position + delta)

func switch_to_aim() -> void:
	current_state = State.AIM

func animate_bullet_switch() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	var new_angle = last_correct_barrel_angle - BULLET_ANGLE
	var bullet_switch_time = bullets.current().bullet_switch_time
	tween.tween_property(bullets_transform_node, "rotation", new_angle, bullet_switch_time)\
		.from(last_correct_barrel_angle)
	tween.tween_callback(switch_to_aim)

	last_correct_barrel_angle = new_angle


func shoot() -> void:
	shoot_player.play()
	var current_bullet = bullets.current()
	var areas = target_tracker.get_overlapping_areas()
	for damage_area in areas:
		damage_target(damage_area, current_bullet)

	earned_points.emit(-20 if areas.is_empty() else 10)

func damage_target(area: TargetArea, bullet: BulletInfo) -> void:
	var multiplier = area.damage_multiplier
	var target = area.target

	if target.hp <= 0:
		return

	var base_damage = bullet.damage
	var total_damage = base_damage

##	Прибавление бонуса/штрафа за дистанцию
	total_damage += base_damage * target.distance * bullet.distance_damage_multiplier

	total_damage *= multiplier

	if multiplier > 1:
		earned_points.emit(int(10 * multiplier))

	earned_points.emit(Math.factorial(target.distance))

	target.take_damage(total_damage)

	if damage_number_layer:
		var damage_number: DamageNumber = Resources.TEMPLATES.damage_number.instantiate()
		damage_number.set_number(total_damage, multiplier > 1)
		damage_number.global_position = global_position
		damage_number_layer.add_child(damage_number)
