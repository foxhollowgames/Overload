extends Timer

func _ready():
	signal_setup()

func turn_start():
	start()

func signal_setup():
	SignalBus.turn_start_pressed.connect(turn_start)
