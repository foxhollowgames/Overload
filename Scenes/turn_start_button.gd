extends Button

func _turn_start_pressed():
	SignalBus.turn_start_pressed.emit()
