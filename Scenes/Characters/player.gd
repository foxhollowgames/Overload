extends character

var energy_max = 5
var energy = 0
var super_power_cost = 5
var barricade = false
var thorns = false
var speed_demon = false
@export var energy_progress_bar : ProgressBar
@export var super_power_label : Label


func _ready():
	super()
	energy_progress_bar.max_value = energy_max
	super_power_label.text = "Chain Lighting"

func _effect(damage, block, energize, super_power, magnet_chance, radius):
	_energize(energize)
	_block(block)
	if super_power: 
		_super_power()

func _energize(energize):
	energy += energize
	energy_progress_bar.value = energy

func _super_power():
	if energy >= super_power_cost:
		energy -= super_power_cost
		energy_progress_bar.value = energy
		SignalBus.chain_lightning_enabled.emit()
