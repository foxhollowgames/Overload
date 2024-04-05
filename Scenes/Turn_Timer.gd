extends Timer

@export var timer_progress : ProgressBar
@export var timer_label : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_progress.max_value = wait_time
	timer_label.text = "Timer"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer_progress.value = self.time_left
