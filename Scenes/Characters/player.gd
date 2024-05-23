extends actor

var super_power_cost = 5
var barricade = false
var thorns = false
var speed_demon = false
var block_increase = 1
var energize = 1

@export var super_power_label : Label

func _ready():
	super()
	signal_setup()
	$AnimatedSprite2D.play()

func _process(delta):
	debug_commands()
	
	if PLAYER_INFO.hp <= 0:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func _effect(power_name):
	print(power_name.text)
	match power_name.text:
		"Brawl": 
			VILLAIN_INFO.take_damage(1)
			animation_player.play("attack_slide")
		"Block":
			PLAYER_INFO.gain_block(1)
		"Energize":
			_energize(energize)
		"Chain Lightning":
			_super_power()
		"Shock":
			VILLAIN_INFO.take_damage(1)
			_energize(energize)
			animation_player.play("attack_slide")
		"Static Shield":
			PLAYER_INFO.gain_block(block_increase)
			_energize(energize)
	SignalBus.power_end.emit()
	squish_squash()

func _energize(energize):
	PLAYER_INFO.energy += energize

func _super_power():
	if PLAYER_INFO.energy >= super_power_cost:
		PLAYER_INFO.energy -= super_power_cost
		#SignalBus.chain_lightning_enabled.emit()
		VILLAIN_INFO.take_damage(3)
		#turn_timer.set_wait_time(turn_timer.time_left + 10)
		#turn_timer.stop()
		#await get_tree().create_timer(10).timeout
		SignalBus.turn_timer_start.emit()

func signal_setup():
	SignalBus.player_damage.connect(PLAYER_INFO.take_damage)
	SignalBus.power.connect(_effect)

func debug_commands():
	if Input.is_action_just_pressed("debug_energize_full"):
		PLAYER_INFO.energy = 1000
	if Input.is_action_just_pressed("debug_player_damage_up"):
		PLAYER_INFO.damage = 1000
	if Input.is_action_just_pressed("debug_player_health_up"):
		PLAYER_INFO.hp_max = 1000
		PLAYER_INFO.hp = 1000
