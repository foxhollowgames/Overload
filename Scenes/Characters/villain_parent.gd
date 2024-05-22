extends actor
class_name villain

var board_interference = 0
var attack = 4
var block_gain = 0
var intention = 0
var intention_options = ["Attack", "Block", "Board Interference"]
@onready var player = $"../../Player"
@export var intention_label : Label
@export var intention_value_label : Label
var intention_value = ''
var villain_name = "Ohm"
@export var villain_label : Label
@onready var fight_scene = $"../../"

func _ready():
	signal_setup()
	hp_max = 10
	hp = hp_max
	block_gain = 2
	villain_label.text = villain_name
	Global.villain_name = self
	print(Global.villain_name)
	_r_intention()
	$AnimatedSprite2D.play()
	super()

func _process(delta):
	debug_commands()

func _effect_villian():
	if (hp <= 0):
		_villain_defeated()

func _villain_turn():
	block = 0
	await get_tree().create_timer(0.2).timeout
	match intention:
		"Attack":
			SignalBus.player_damage.emit(attack)
			animation_player.play("attack_slide")
		"Block":
			self._block(block_gain)
		"Board Interference":
			_board_interference()
	
	_r_intention()
	squish_squash()
	#TODO MAKE THIS NOT A TIMER YUCKITY YUCKITY YUCK DRUCKS MCDUCKS
	await get_tree().create_timer(0.5).timeout
	_villain_turn_end()

func _villain_turn_end():
	SignalBus.villain_turn_end.emit()

func _board_interference():
	SignalBus.spawn_bouncy.emit()

func _r_intention():
	intention =  intention_options.pick_random()
	if (intention == intention_options[0]):
		intention_value = str(attack)
	if (intention == intention_options[1]):
		intention_value = str(block_gain)
	intention_value_label.text = intention_value
	intention_label.text = str(self.intention)

func _villain_defeated():
	SignalBus.villain_defeated.emit()

func signal_setup():
	SignalBus.power_end.connect(_effect_villian)
	SignalBus.turn_end.connect(_villain_turn)

func debug_commands():
	if Input.is_action_just_pressed("debug_villain_health_down"):
		hp = 1
