extends ProgressBar
@onready var timer: Timer = $".."
var seconds

func _process(delta: float) -> void:
	seconds = timer.time_left
	value = seconds
	max_value = timer.wait_time
