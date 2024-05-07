extends Node

# Powers
@onready var power_chain_lightning = $Powers/PowerChainLightning
@onready var power_static_shield = $Powers/PowerStaticShield
@onready var power_shock = $Powers/PowerShock
@onready var power_energize = $Powers/PowerEnergize
@onready var power_block = $Powers/PowerBlock
@onready var power_brawl = $Powers/PowerBrawl
@onready var power_array = [power_chain_lightning, power_static_shield, power_shock, power_energize, power_block, power_brawl]

# Depracated super power variables
var ball_lightning_charges = 0
var ball_lightning = false
var barricade = false
var thorns = false
var speed_demon = false
@export var super_power_count_label : Label

func _ready():
	#relic_setup()
	signal_setup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _barricade_enabled():
	barricade = true

func _thorns_enabled():
	thorns = true

func _speed_demon_enabled():
	speed_demon = true

func _speed_demon_disable():
	speed_demon = false

# Check if there is ANY power active, and if not, clear the state
func _is_power_active(power_name):
	var is_active = false
	
	for _i in power_array.size():
		if power_array[_i].active:
			is_active = true
	
	if not is_active:
		SignalBus.clear_combo.emit()

#func relic_setup():
	#for _i in range (Global.relics_acquired.size()):
		#match Global.relics_acquired[_i]:
			#"Barricade": 
				#SignalBus.barricade.emit()
			#"Thorns": 
				#SignalBus.thorns.emit()
			#"Speed Demon": 
				#SignalBus.speed_demon.emit()

# Chain lightning power
func _set_chain_lightning_charges():
	#ball_lightning_charges += 5
	pass

func _ball_lightning_check(power_name):
	#if ball_lightning_charges > 0:
		#ball_lightning = true
		#ball_lightning_charges -= 1
		#super_power_count_label.text = str(ball_lightning_charges)
	#else:
		#ball_lightning = false
	pass
	
func signal_setup():
	SignalBus.chain_lightning_enabled.connect(_set_chain_lightning_charges)
	SignalBus.clicked.connect(_ball_lightning_check)
	SignalBus.clicked.connect(_is_power_active)
	SignalBus.barricade.connect(_barricade_enabled)
	SignalBus.thorns.connect(_thorns_enabled)
	SignalBus.speed_demon.connect(_speed_demon_enabled)
