extends power

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	power_name.text = "Chain Lightning"
	POWER = [SYMBOL_SUPER_POWER, SYMBOL_SUPER_POWER, SYMBOL_ENERGIZE, SYMBOL_SUPER_POWER, SYMBOL_ENERGIZE, SYMBOL_SUPER_POWER]
	array_state = [false, false, false, false, false, false]
