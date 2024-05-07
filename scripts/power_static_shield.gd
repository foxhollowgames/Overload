extends power

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	power_name.text = "Static Shield"
	POWER = [SYMBOL_BLOCK, SYMBOL_BLOCK, SYMBOL_BLOCK, SYMBOL_ENERGIZE, SYMBOL_ENERGIZE, SYMBOL_SUPER_POWER]
	array_state = [false, false, false, false, false, false]
