extends character
class_name villain

var board_interference = 0
var attack = 2
var block_gain = 0
var intention = 0
var intention_options = ["Attack", "Block", "Board Interference"]
@onready var player = $"../Player"
@export var intention_label : Label
@export var intention_value_label : Label
var intention_value = ''
var villain_name = "Ohm"
@export var villain_label : Label
@onready var fight_scene = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.power.connect(_effect_villian)
	SignalBus.turn_end.connect(_villain_turn)
	hp_max = 20
	hp = hp_max
	block_gain = 5
	villain_label.text = villain_name
	_r_intention()
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _effect_villian(power_name):
	if (hp <= 0):
		SignalBus.villain_defeated.emit()

func _villain_turn():
	match intention:
		"Attack":
			player._damage(attack)
		"Block":
			self._block(block_gain)
		"Board Interference":
			_board_interference()
	
	_r_intention()
	
	_villain_turn_end()

func _villain_turn_end():
	SignalBus.villain_turn_end.emit()

func _board_interference():
	fight_scene._spawn_bouncy()

func _r_intention():
	intention =  intention_options.pick_random()
	if (intention == intention_options[0]):
		intention_value = str(attack)
	if (intention == intention_options[1]):
		intention_value = str(block)
	intention_value_label.text = intention_value
	intention_label.text = str(self.intention)
