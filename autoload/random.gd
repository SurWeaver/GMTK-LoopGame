extends Node


var rng: RandomNumberGenerator


func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()

func get_float(from: float, to: float) -> float:
	return rng.randf_range(from, to)


func get_random_child(node: Node) -> Node:
	var child_count = node.get_child_count()
	return node.get_child(get_random_index(child_count))

func get_unrepeated_indices(size: int, count: int) -> Array[int]:
	var indices: Array[int] = []

	while indices.size() < count:
		var random_index = get_random_index(size)
		if random_index not in indices:
			indices.append(random_index)
	return indices

func get_random_index(size: int) -> int:
	return rng.randi_range(0, size - 1)
