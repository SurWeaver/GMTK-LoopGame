extends Node


var rng: RandomNumberGenerator


func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()

func get_float(from: float, to: float) -> float:
	return rng.randf_range(from, to)
