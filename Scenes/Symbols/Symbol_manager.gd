extends Node2D

var can_spawn = true
const SYMBOL_BRAWL = preload("res://Scenes/Symbols/symbol_brawl.tscn")
const SYMBOL_BLOCK = preload("res://Scenes/Symbols/symbol_block.tscn")
const SYMBOL_ENERGIZE = preload("res://Scenes/Symbols/symbol_energize.tscn")
const SYMBOL_MAGNET = preload("res://Scenes/Symbols/symbol_magnet.tscn")
const SYMBOL_SUPER_POWER = preload("res://Scenes/Symbols/symbol_super_power.tscn")
const SYMBOL_BOUNCY = preload("res://Scenes/Symbols/bouncy_peg.tscn")
var current_symbol_type = 0
var symbol_type_array = [SYMBOL_BRAWL, SYMBOL_BLOCK, SYMBOL_ENERGIZE, SYMBOL_SUPER_POWER]
var ball_lightning_charges = 0
var ball_lightning = false
@onready var turn_timer = $Turn_Timer
@export var super_power_count_label : Label
var game_over : = "res://Scenes/game_over.tscn"
var relic_choice_scene : = "res://Scenes/relic_choice.tscn"
var barricade = false
var thorns = false
var speed_demon = false
@onready var speed_demon_timer = get_parent().get_node("Speed_demon_timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.chain_lightning_enabled.connect(_set_chain_lightning_charges)
	SignalBus.clicked.connect(_ball_lightning_check)
	SignalBus.villain_turn_end.connect(_turn_start)
	SignalBus.villain_defeated.connect(_villain_defeated)
	SignalBus.barricade.connect(_barricade_enabled)
	SignalBus.thorns.connect(_thorns_enabled)
	SignalBus.speed_demon.connect(_speed_demon_enabled)
	
	for _i in range (Global.relics_acquired.size()):
		match Global.relics_acquired[_i]:
			"Barricade": 
				SignalBus.barricade.emit()
			"Thorns": 
				SignalBus.thorns.emit()
			"Speed Demon": 
				SignalBus.speed_demon.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Chain lightning power
func _set_chain_lightning_charges():
	ball_lightning_charges += 5

func _ball_lightning_check(damage, block, energize, super_power, magnet_chance, radius):
	if ball_lightning_charges > 0:
		ball_lightning = true
		ball_lightning_charges -= 1
		super_power_count_label.text = str(ball_lightning_charges)
	else:
		ball_lightning = false

func _turn_start():
	_can_spawn()
	turn_timer.start()
	$Speed_demon_timer.start()

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
	symbol_create.position.y = 0
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
	get_tree().change_scene_to_file(relic_choice_scene)

func _barricade_enabled():
	barricade = true

func _thorns_enabled():
	thorns = true

func _speed_demon_enabled():
	speed_demon = true

func _speed_demon_disable():
	speed_demon = false
