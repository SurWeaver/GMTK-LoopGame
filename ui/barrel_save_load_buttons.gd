extends HBoxContainer

signal load_barrel(barrel_index: int)
signal save_to_barrel(barrel_index: int)

@export var visible_number: int
@export var real_number: int


func _ready() -> void:
	$BarrelNumber.text = str(visible_number)

func _on_load_button_pressed() -> void:
	load_barrel.emit(real_number)

func _on_save_button_pressed() -> void:
	save_to_barrel.emit(real_number)
