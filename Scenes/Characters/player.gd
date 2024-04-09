extends character

var energy_max = 5
var energy = 0
var super_power_cost = 5
var barricade = false
var thorns = false
var speed_demon = false
@export var energy_progress_bar : ProgressBar
@export var super_power_label : Label
@onready var villain_parent = $"../Villain_Parent"

func _ready():
	super()
	energy_progress_bar.max_value = energy_max
	SignalBus.power.connect(_effect)
	$AnimatedSprite2D.play()

func _process(delta):
	if hp <= 0:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func _effect(power_name):
	print(power_name)
	match power_name:
		"Brawl": 
			villain_parent._damage(1)
		"Block":
			_block(1)
		"Energize":
			_energize(1)
		"Chain Lightning":
			_super_power()
		"Shock":
			villain_parent._damage(1)
			_energize(1)
		"Static Shield":
			_block(1)
			_energize(1)

func _energize(energize):
	energy += energize
	energy_progress_bar.value = energy

func _super_power():
	if energy >= super_power_cost:
		energy -= super_power_cost
		energy_progress_bar.value = energy
		SignalBus.chain_lightning_enabled.emit()
