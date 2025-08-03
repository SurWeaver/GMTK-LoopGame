class_name PointLabel
extends Label

var points: int = 0

var enabled: bool = false

func _ready() -> void:
	update_text()

func enable() -> void:
	enabled = true

func disable() -> void:
	enabled = false

func add_points(new_points: int) -> void:
	if not enabled:
		return

	points += new_points
	update_text()

func update_text() -> void:
	text = "%d %s" % [points, tr("points_suffix")]
