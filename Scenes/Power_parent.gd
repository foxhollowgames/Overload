extends Node2D
class_name power

var SYMBOL_BRAWL = Global.symbol_type.BRAWL
var SYMBOL_BLOCK = Global.symbol_type.BLOCK
var SYMBOL_ENERGIZE = Global.symbol_type.ENERGIZE
var SYMBOL_SUPER_POWER = Global.symbol_type.SUPER_POWER
var symbol_type
@export var power_name : Label

var power_state = false
var array_state = [false, false, false]
@onready var ui_symbols = [$"1", $"2", $"3", $"4", $"5", $"6"]

var POWER = [SYMBOL_BRAWL, SYMBOL_BRAWL, SYMBOL_BLOCK]

var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.clicked.connect(_power_check)
	SignalBus.turn_end.connect(_clear_combo)
	SignalBus.power.connect(_clear_combo)
	SignalBus.clear_combo.connect(_clear_combo)

func _power_check(symbol_type):
	#print("Power section: ")
	#print(Global.combo)
	
	var slice = POWER.slice(0, Global.combo.size())
	if Global.combo == slice:
		#print_debug(slice)
		#print_debug(Global.combo)
		power_state = true
		for _i in POWER.size():
			ui_symbols[_i].self_modulate.a = 0.5
		for _i in Global.combo.size():
			array_state[_i] = true
			ui_symbols[_i].self_modulate.a = 1
		
		$ColorRect.self_modulate.a = 1
		$Power_name.self_modulate.a = 1
		active = true
	
	else: 
		active = false
		$Power_name.self_modulate.a = 0.5
		for _j in POWER.size():
			array_state[_j] = false
			ui_symbols[_j].self_modulate.a = 0.5
	
	if Global.combo == POWER:
		print("power.emit!")
		SignalBus.power.emit(power_name.text)
		active = false

func _clear_combo(_power_name = ""):
	Global.combo.clear()
	power_state = false
	for _j in POWER.size():
		array_state[_j] = false
		$Power_name.self_modulate.a = 1
		ui_symbols[_j].self_modulate.a = 1
