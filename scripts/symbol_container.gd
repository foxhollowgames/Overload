extends Polygon2D

# Symbol loading
var SYMBOL_BRAWL = load("res://scenes/symbols/symbol_brawl.tscn")
var SYMBOL_BLOCK = load("res://scenes/symbols/symbol_block.tscn")
var SYMBOL_ENERGIZE = load("res://scenes/symbols/symbol_energize.tscn")
var SYMBOL_SUPER_POWER = load("res://scenes/symbols/symbol_super_power.tscn")
var SYMBOL_BOUNCY = load("res://scenes/symbols/bouncy_peg.tscn")
var current_symbol_type = 0
var symbol_type_array = [SYMBOL_BRAWL, SYMBOL_BLOCK, SYMBOL_ENERGIZE, SYMBOL_SUPER_POWER]

var can_spawn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_tree().create_timer(time).timeout.connect(to something)
	signal_setup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Spawn in symbols
func _spawn_toggle():
	can_spawn = !can_spawn

func _spawn():
	if not can_spawn:
		return
	var random_symbol = symbol_type_array.pick_random()
	var symbol_create = random_symbol.instantiate()
	var random_x = randi_range(-100, 100)
	symbol_create.position.x = random_x
	symbol_create.position.y = -150
	add_child(symbol_create)
	#Relics that are no longer used in the game
	#match symbol_create.symbol_type:
		#0:
			#if barricade:
				#symbol_create.barricade = true
			#if thorns:
				#symbol_create.thorns = true
	#if speed_demon:
		#symbol_create.speed_demon = true

func _spawn_bouncy():
	#var random_x = randi_range(-200, 200)
	#var random_y = randi_range(-200, 200)
	#TODO: Figure out random spawning
	var coord = $NavigationRegion2D.map_get_random_point()
	var _interference_create = SYMBOL_BOUNCY.instantiate()
	add_child(_interference_create)
	_interference_create.global_position = coord
	#_interference_create.global_position.x = random_x
	#_interference_create.global_position.y = random_y

func signal_setup():
	SignalBus.spawn_toggle.connect(_spawn_toggle)
	SignalBus.spawn_bouncy.connect(_spawn_bouncy)
