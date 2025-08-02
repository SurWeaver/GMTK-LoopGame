class_name Target
extends Node2D

const HIT_DURATION: float = 0.2
const APPEAR_DURATION: float = 0.5
const DEATH_DURATION: float = 0.5
const MAX_APPEAR_DELAY: float = 0.5

signal died

@export var hp: float = 1
@export_range(1, 6, 1, "or_greater") var distance: int = 1

@export var visual_height: float = 100

@export var visual_node: CanvasItem
@export var hit_scale: Vector2 = Vector2(0.9, 0.9)


func _init() -> void:
	hide()

func _ready() -> void:
	animate_appear()

func animate_appear() -> void:
	var initial_position = position + Vector2.DOWN * visual_height
	var target_position = position
	position = initial_position

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	tween.tween_interval(get_random_delay())
	tween.tween_callback(show)

	tween.tween_property(self, "position", target_position, APPEAR_DURATION)\
		.set_delay(get_random_delay())

func animate_hit() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(visual_node, "scale", hit_scale, HIT_DURATION / 2.0)
	tween.tween_property(visual_node, "scale", Vector2.ONE, HIT_DURATION / 2.0)
	pass

func animate_death() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)

	tween.tween_property(self, "position", position + Vector2.DOWN * visual_height, DEATH_DURATION)
	tween.set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(visual_node, "scale", hit_scale, DEATH_DURATION / 2.0)
	tween.tween_callback(died.emit)
	tween.tween_callback(queue_free)

func get_random_delay() -> float:
	return Random.get_float(0, MAX_APPEAR_DELAY)

func take_damage(damage_amount: float) -> void:
	if hp <= 0:
		return

	hp -= damage_amount
	if hp <= 0:
		animate_death()
	else:
		animate_hit()
