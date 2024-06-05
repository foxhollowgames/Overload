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

var inside = false

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
	var markers = [$"Symbol Spawners/Marker1", $"Symbol Spawners/Marker2", $"Symbol Spawners/Marker3", $"Symbol Spawners/Marker4", $"Symbol Spawners/Marker5", $"Symbol Spawners/Marker6", $"Symbol Spawners/Marker7", $"Symbol Spawners/Marker8", $"Symbol Spawners/Marker9"]
	var random_marker = markers.pick_random()
	var random_symbol = symbol_type_array.pick_random()
	var symbol_create = random_symbol.instantiate()
	
	add_child(symbol_create)
	print("Marker: " + str(random_marker))
	print("Marker POS: " + str(random_marker.position))
	symbol_create.global_position = random_marker.global_position

func _spawn_bouncy():
	var markers = [$"Interfere Spawners/Marker1", $"Interfere Spawners/Marker2", $"Interfere Spawners/Marker3", $"Interfere Spawners/Marker4", $"Interfere Spawners/Marker5", $"Interfere Spawners/Marker6", $"Interfere Spawners/Marker7", $"Interfere Spawners/Marker8", $"Interfere Spawners/Marker9"]
	var random_marker = markers.pick_random()
	var _interference_create = SYMBOL_BOUNCY.instantiate()
	
	add_child(_interference_create)
	_interference_create.global_position = random_marker.global_position

func signal_setup():
	SignalBus.spawn_toggle.connect(_spawn_toggle)
	SignalBus.spawn_bouncy.connect(_spawn_bouncy)
