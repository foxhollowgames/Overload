extends Node

var relics_acquired = []
var thorns_count = 0
@export var fight_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.relic_picked.connect(_relic_add)

func _relic_add(title):
	relics_acquired.append(title)
	print_debug(relics_acquired)
