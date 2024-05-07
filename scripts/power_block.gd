extends power

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	power_name.text = "Block"
	POWER = [SYMBOL_BLOCK, SYMBOL_BLOCK, SYMBOL_BRAWL]
	array_state = [false, false, false]
