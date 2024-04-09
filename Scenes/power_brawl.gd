extends power

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	power_name.text = "Brawl"
	POWER = [SYMBOL_BRAWL, SYMBOL_BRAWL, SYMBOL_BLOCK]
	array_state = [false, false, false]
