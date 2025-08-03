class_name DamageNumber
extends Control

const FALL_DISTANCE: float = 2000
const SIDE_RANGE: float = 500
const FALL_DURATION: float  = 1


func _ready() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)

	var final_position = position + Vector2(Random.get_float(-SIDE_RANGE, SIDE_RANGE), FALL_DISTANCE)
	tween.tween_property(self, "position:y", final_position.y, FALL_DURATION)

	tween.set_trans(Tween.TRANS_LINEAR)
	tween.parallel().tween_property(self, "position:x", final_position.x, FALL_DURATION)
	tween.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(self, "modulate", Color.TRANSPARENT, FALL_DURATION)

	tween.tween_callback(queue_free)

#TODO: Можно сделать множитель ниже 1, чтобы сделать бронированные части врагов
func set_number(number: float, is_crit: bool) -> void:
	var label = $Label
	label.text = str(roundi(number))
	label.theme_type_variation = &"CritDamageLabel" if is_crit else &"DamageLabel"
