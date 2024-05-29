extends Timer

@export var timer_progress : ProgressBar
@export var timer_label : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	signal_setup()
	timer_progress.max_value = wait_time
	timer_label.text = "Timer"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	debug_commands()
	
	timer_progress.value = self.time_left

func _turn_timer_start():
	start()

func _turn_end():
	SignalBus.spawn_toggle.emit()
	SignalBus.turn_end.emit()

func signal_setup():
	SignalBus.turn_start_pressed.connect(_turn_timer_start)
	SignalBus.turn_timer_start.connect(_turn_timer_start)

func debug_commands():
	if Input.is_action_just_pressed("debug_turn_end"):
		stop()
		timeout.emit()
