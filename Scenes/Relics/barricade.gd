extends Relic


# Called when the node enters the scene tree for the first time.
func _ready():
	description = 'Fallen block symbols give a small amount of Block'
	title = 'Barricade'
	super()

func _pressed():
	SignalBus.relic_picked.emit(title)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
