extends Node



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
	#SignalBus.chain_lightning_enabled.connect(_set_chain_lightning_charges)
	#SignalBus.clicked.connect(_ball_lightning_check)

	SignalBus.barricade.connect(_barricade_enabled)
	SignalBus.thorns.connect(_thorns_enabled)
	SignalBus.speed_demon.connect(_speed_demon_enabled)
