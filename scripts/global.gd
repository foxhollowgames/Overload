extends Node

var relics_acquired = []
var thorns_count = 0
@export var fight_scene : PackedScene

enum symbol_type {
	BLOCK, BRAWL, ENERGIZE, MAGNET, SUPER_POWER
	}
var combo = []

var SYMBOL_BRAWL = load("res://scenes/Symbols/symbol_brawl.tscn")
var SYMBOL_BLOCK = load("res://scenes/Symbols/symbol_block.tscn")
var SYMBOL_ENERGIZE = load("res://scenes/Symbols/symbol_energize.tscn")
var SYMBOL_MAGNET = load("res://scenes/Symbols/symbol_magnet.tscn")
var SYMBOL_SUPER_POWER = load("res://scenes/Symbols/symbol_super_power.tscn")
var SYMBOL_BOUNCY = load("res://scenes/Symbols/bouncy_peg.tscn")

var brawl_state = false
var brawl_array_state = [false, false, false]
var POWER_BLOCK = [SYMBOL_BLOCK, SYMBOL_BRAWL, SYMBOL_BLOCK]
var block_state = false
var block_array_state = [false, false, false]
var POWER_ENERGIZE = [SYMBOL_ENERGIZE, SYMBOL_SUPER_POWER, SYMBOL_ENERGIZE,SYMBOL_SUPER_POWER, SYMBOL_ENERGIZE]
var energize_state = false
var energize_array_state = [false, false, false, false, false]
var POWER_CHAIN_LIGHTNING = [SYMBOL_SUPER_POWER, SYMBOL_SUPER_POWER, SYMBOL_ENERGIZE, SYMBOL_SUPER_POWER, SYMBOL_ENERGIZE, SYMBOL_ENERGIZE, SYMBOL_SUPER_POWER]
var chain_lightning_state = false
var chain_lightning_array_state = [false, false, false, false, false, false, false]
var POWER_SHOCK = [SYMBOL_BRAWL, SYMBOL_BRAWL, SYMBOL_ENERGIZE, SYMBOL_ENERGIZE, SYMBOL_SUPER_POWER]
var shock_state = false
var shock_array_state = [false, false, false, false, false]
var POWER_STATIC_SHIELD = [SYMBOL_BLOCK, SYMBOL_BLOCK, SYMBOL_BLOCK, SYMBOL_ENERGIZE, SYMBOL_ENERGIZE, SYMBOL_SUPER_POWER]
var static_shield_state = false
var static_shield_array_state = [false, false, false, false, false, false]

var villain_name = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#SignalBus.relic_picked.connect(_relic_add)
#
#func _relic_add(title):
	#relics_acquired.append(title)

func _pitch(sound):
	sound.AudioEffectPitchShift
