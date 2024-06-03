extends ActorResource
class_name VillainResource

@export var intention_options = {
	"attack": {"value": [1, 2, 3, 4], "odds": 20}, 
	"block": {"value": [1, 2, 3, 4], "odds": 20}, 
	"interfere": {"type": "res://scenes/symbols/bouncy_peg.tscn", "odds": 20}, 
	"buff": {"value": 1, "odds": 20}, 
	"debuff": {"value": 1, "odds": 20}
}
@export var intention_icon : Texture2D
var intention = ''
var value = 0

@export var damage = 0:
	get:
		return intention_options.attack.value.pick_random() + strength
@export var block_r = 0:
	get:
		return intention_options.block.value.pick_random()

var strength = 0
var sap = 0

func intention_set():
	var weights = PackedFloat32Array([intention_options.attack.odds, intention_options.block.odds, intention_options.interfere.odds, intention_options.buff.odds, intention_options.debuff.odds])
	var rng = RandomNumberGenerator.new()
	
	intention = intention_options.keys()[rng.rand_weighted(weights)]
	match intention:
		"attack":
			value = intention_options.attack.value.pick_random()
		"block":
			value = intention_options.attack.value.pick_random()

func villain_gain_strength():
	strength += intention_options.buff.value

func hero_loses_strength():
	sap += intention_options.debuff.value
