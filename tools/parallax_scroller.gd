class_name ParallaxScroller
extends Node


@export var parallax: Parallax2D
@export var speed: float = 100


func _process(delta: float) -> void:
	parallax.scroll_offset.x += speed * delta
