extends actor

var super_power_cost = 5
var barricade = false
var thorns = false
var speed_demon = false
var block_increase = 1
var energize = 1

func _ready():
	signal_setup()
	$AnimatedSprite2D.play()

func _process(_delta):
	debug_commands()
	
	if PLAYER_INFO.hp <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func effect(power_name):
	print(power_name.text)
	match power_name.text:
		"Brawl": 
			var damage = 1
			var total_damage = damage - VILLAIN_INFO.sap
			if total_damage < 0:
				total_damage = 0
			SignalBus.villain_damage.emit(total_damage)
			animation_player.play("attack_slide")
		"Block":
			PLAYER_INFO.gain_block(1)
		"Energize":
			_energize(energize)
		"Chain Lightning":
			super_power()
		"Shock":
			var damage = 1
			var total_damage = damage - VILLAIN_INFO.sap
			if total_damage < 0:
				total_damage = 0
			SignalBus.villain_damage.emit(total_damage)
			_energize(energize)
			animation_player.play("attack_slide")
		"Static Shield":
			PLAYER_INFO.gain_block(block_increase)
			_energize(energize)
	SignalBus.power_end.emit()
	squish_squash()

func _energize(energy):
	PLAYER_INFO.energy += energy

func super_power():
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
	SignalBus.power.connect(effect)

func debug_commands():
	if Input.is_action_just_pressed("debug_energize_full"):
		PLAYER_INFO.energy = 1000
	if Input.is_action_just_pressed("debug_player_damage_up"):
		PLAYER_INFO.damage = 1000
	if Input.is_action_just_pressed("debug_player_health_up"):
		PLAYER_INFO.hp_max = 1000
		PLAYER_INFO.hp = 1000
