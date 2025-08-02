class_name TargetTracker
extends Node

@export var tracker_area: Area2D

var _areas: Array[TargetArea]

func _ready() -> void:
	if not tracker_area:
		push_error("There's no area")
		return

	tracker_area.area_entered.connect(_on_area_enter)
	tracker_area.area_exited.connect(_on_area_exit)

func _on_area_enter(area: Area2D) -> void:
	if area in _areas:
		return
	if area is TargetArea:
		_areas.append(area)

func _on_area_exit(area: Area2D) -> void:
	if area in _areas:
		_areas.erase(area)

func get_overlapping_areas() -> Array[TargetArea]:
	return _areas.duplicate()
