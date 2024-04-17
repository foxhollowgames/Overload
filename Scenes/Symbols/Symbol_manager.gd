extends Node2D

var can_spawn = true
var SYMBOL_BRAWL = load("res://Scenes/Symbols/symbol_brawl.tscn")
var SYMBOL_BLOCK = load("res://Scenes/Symbols/symbol_block.tscn")
var SYMBOL_ENERGIZE = load("res://Scenes/Symbols/symbol_energize.tscn")
var SYMBOL_MAGNET = load("res://Scenes/Symbols/symbol_magnet.tscn")
var SYMBOL_SUPER_POWER = load("res://Scenes/Symbols/symbol_super_power.tscn")
var SYMBOL_BOUNCY = load("res://Scenes/Symbols/bouncy_peg.tscn")
var current_symbol_type = 0
var symbol_type_array = [SYMBOL_BRAWL, SYMBOL_BLOCK, SYMBOL_ENERGIZE, SYMBOL_SUPER_POWER]
var ball_lightning_charges = 0
var ball_lightning = false
@onready var turn_timer = $TurnTimer
@export var super_power_count_label : Label
var game_over : = "res://Scenes/game_over.tscn"
var game_end = "res://Scenes/game_end.tscn"
var relic_choice_scene : = "res://Scenes/relic_choice.tscn"
var barricade = false
var thorns = false
var speed_demon = false
@onready var speed_demon_timer = $SpeedDemonTimer
var TURN_START_UI = load("res://Scenes/canvas_layer.tscn")

@onready var power_chain_lightning = $PowerChainLightning
@onready var power_static_shield = $PowerStaticShield
@onready var power_shock = $PowerShock
@onready var power_energize = $PowerEnergize
@onready var power_block = $PowerBlock
@onready var power_brawl = $PowerBrawl
@onready var power_array = [power_chain_lightning, power_static_shield, power_shock, power_energize, power_block, power_brawl]

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.chain_lightning_enabled.connect(_set_chain_lightning_charges)
	SignalBus.clicked.connect(_ball_lightning_check)
	SignalBus.clicked.connect(_is_power_active)
	SignalBus.villain_turn_end.connect(_turn_ini)
	SignalBus.villain_defeated.connect(_villain_defeated)
	SignalBus.barricade.connect(_barricade_enabled)
	SignalBus.thorns.connect(_thorns_enabled)
	SignalBus.speed_demon.connect(_speed_demon_enabled)
	SignalBus.turn_start_pressed.connect(_turn_start)
	
	for _i in range (Global.relics_acquired.size()):
		match Global.relics_acquired[_i]:
			"Barricade": 
				SignalBus.barricade.emit()
			"Thorns": 
				SignalBus.thorns.emit()
			"Speed Demon": 
				SignalBus.speed_demon.emit()

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

func _turn_ini():
	add_child(TURN_START_UI.instantiate())

func _turn_start():
	_can_spawn()
	$"SymbolTimers/PreTurn".start()
	$SymbolTimers/Timer.start()
	$CanvasLayer.queue_free()

func _turn_timer_start():
	turn_timer.start()
	$SpeedDemonTimer.start()

# Turn timer end
func _turn_end():
	_cannot_spawn()
	SignalBus.turn_end.emit()

# Spawn in symbols
func _can_spawn():
	can_spawn = true

func _cannot_spawn():
	can_spawn = false

func _spawn():
	if not can_spawn:
		return
	var random_symbol = symbol_type_array.pick_random()
	var symbol_create = random_symbol.instantiate()
	var random_x = randi_range(75, 260)
	symbol_create.position.x = random_x
	symbol_create.position.y = -50
	match symbol_create.symbol_type:
		0:
			if barricade:
				symbol_create.barricade = true
			if thorns:
				symbol_create.thorns = true
	if speed_demon:
		symbol_create.speed_demon = true
	add_child(symbol_create)

func _spawn_bouncy():
	var random_x = randi_range(75, 260)
	var random_y = randi_range(25, 130)
	var _interference_create = SYMBOL_BOUNCY.instantiate()
	_interference_create.global_position.x = random_x
	_interference_create.global_position.y = random_y
	add_child(_interference_create)

func _villain_defeated():
	$RelicTransition.play()
	await get_tree().create_timer(2).timeout
	#get_tree().change_scene_to_file(relic_choice_scene)
	get_tree().change_scene_to_file("res://Scenes/game_end.tscn")

func _barricade_enabled():
	barricade = true

func _thorns_enabled():
	thorns = true

func _speed_demon_enabled():
	speed_demon = true

func _speed_demon_disable():
	speed_demon = false

func _is_power_active(power_name):
	var is_active = false
	
	for _i in power_array.size():
		if power_array[_i].active:
			is_active = true
			
	if not is_active:
		SignalBus.clear_combo.emit()
