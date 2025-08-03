extends Control


@warning_ignore("unused_signal")
signal started


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("Start")
