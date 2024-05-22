extends actor

var energy_max = 5
var energy = 0
var super_power_cost = 5
var barricade = false
var thorns = false
var speed_demon = false
var block_increase = 1
var damage = 1
var energize = 1

@export var energy_progress_bar : ProgressBar
@export var super_power_label : Label
#@onready var parent = $".."
@onready var villain_name = Global.villain_name

func _ready():
	super()
	signal_setup()
	energy_progress_bar.max_value = energy_max
	$AnimatedSprite2D.play()

func _process(delta):
	debug_commands()
	
	if hp <= 0:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func _effect(power_name):
	print(power_name.text)
	match power_name.text:
		"Brawl": 
			villain_name._damage(damage)
			animation_player.play("attack_slide")
		"Block":
			_block(block_increase)
		"Energize":
			_energize(energize)
		"Chain Lightning":
			_super_power()
		"Shock":
			villain_name._damage(damage)
			_energize(energize)
			animation_player.play("attack_slide")
		"Static Shield":
			_block(block_increase)
			_energize(energize)
	SignalBus.power_end.emit()
	squish_squash()

func _energize(energize):
	energy += energize
	energy_progress_bar.value = energy

func _super_power():
	if energy >= super_power_cost:
		energy -= super_power_cost
		energy_progress_bar.value = energy
		#SignalBus.chain_lightning_enabled.emit()
		villain_name._damage(3)
		#turn_timer.set_wait_time(turn_timer.time_left + 10)
		#turn_timer.stop()
		#await get_tree().create_timer(10).timeout
		SignalBus.turn_timer_start.emit()

func signal_setup():
	SignalBus.player_damage.connect(_damage)
	SignalBus.power.connect(_effect)

func debug_commands():
	if Input.is_action_just_pressed("debug_energize_full"):
		energy = 1000
	if Input.is_action_just_pressed("debug_player_damage_up"):
		damage = 1000
	if Input.is_action_just_pressed("debug_player_health_up"):
		hp_max = 1000
		hp = 1000
