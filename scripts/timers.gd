extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	signal_setup()
	
	for timer in get_children():
		timer.wait_time = randf_range(.05, .2)

func turn_start():
	$PreTurn.start()
	$SpawnTimer.start()

func signal_setup():
	SignalBus.turn_start_pressed.connect(turn_start)
