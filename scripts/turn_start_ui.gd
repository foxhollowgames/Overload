extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	signal_setup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func turn_started():
	SignalBus.spawn_toggle.emit()
	queue_free()

func signal_setup():
	SignalBus.turn_start_pressed.connect(turn_started)
