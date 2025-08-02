class_name TargetPlaceDispenser
extends Node2D


func get_shuffled_free_places(place_amount: int) -> Array[CanvasItem]:
	var free_places = get_free_places()
	assert(place_amount <= free_places.size())

	var indices = Random.get_unrepeated_indices(free_places.size(), place_amount)
	var shuffled_places: Array[CanvasItem] = []
	for idx in indices:
		shuffled_places.append(free_places[idx])

	return shuffled_places


func get_free_places() -> Array[CanvasItem]:
	if not has_free_place():
		return []

	var free_places: Array[CanvasItem] = []

	for child in get_children():
		if child.get_child_count() == 0:
			free_places.append(child)

	return free_places

func has_free_place() -> bool:
	for child in get_children():
		if child.get_child_count() == 0:
			return true
	return false
