class_name TimerLabel
extends Label

var passed_seconds: float = 0

func _ready() -> void:
	update_text()
	stop()

func start() -> void:
	set_process(true)

func stop() -> void:
	set_process(false)


func _process(delta: float) -> void:
	passed_seconds += delta
	update_text()

func update_text() -> void:
	text = "%3.1f %s" % [passed_seconds, tr("seconds_suffix")]
