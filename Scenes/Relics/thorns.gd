extends Relic


# Called when the node enters the scene tree for the first time.
func _ready():
	description = 'Every 3 Block clicked, gain 1 Brawl'
	title = 'Thorns'
	super()

func _pressed():
	SignalBus.relic_picked.emit(title)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
