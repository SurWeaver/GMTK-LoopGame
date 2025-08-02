@tool
class_name TargetArea
extends Area2D


@export var damage_multiplier: float = 1

@export var target: Target


func _ready() -> void:
	if not target:
		var parent = get_parent()
		while parent is not Target:
			parent = parent.get_parent()

		target = parent as Target
