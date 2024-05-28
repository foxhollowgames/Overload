extends actor
class_name villain

var board_interference = 0
var intention = 0
var intention_options = ["Attack", "Block", "Board Interference"]
@export var intention_label : Label
@export var intention_value_label : Label
var intention_value = ''
@export var villain_label : Label
#@onready var fight_scene = $"../../"

func _ready():
	signal_setup()
	print(Global.villain_name)
	_r_intention()
	$AnimatedSprite2D.play()
	super()

func _process(delta):
	debug_commands()

func _effect_villian():
	if (VILLAIN_INFO.hp <= 0):
		_villain_defeated()

func _villain_turn():
	VILLAIN_INFO.block = 0
	await get_tree().create_timer(0.2).timeout
	match intention:
		"Attack":
			SignalBus.player_damage.emit(4)
			animation_player.play("attack_slide")
		"Block":
			VILLAIN_INFO.gain_block(4)
		"Board Interference":
			_board_interference()
	SignalBus.power.emit()
	squish_squash()
	intention_value = ''
	_r_intention()
	#TODO MAKE THIS NOT A TIMER YUCKITY YUCKITY YUCK DRUCKS MCDUCKS. Could we just await squish_squash?
	await get_tree().create_timer(0.5).timeout
	_villain_turn_end()

func _villain_turn_end():
	SignalBus.villain_turn_end.emit()

func _board_interference():
	SignalBus.spawn_bouncy.emit()

func _r_intention():
	intention =  intention_options.pick_random()
	if (intention == intention_options[0]):
		intention_value = '4'
	if (intention == intention_options[1]):
		intention_value = '4'
	intention_value_label.text = intention_value
	intention_label.text = str(self.intention)

func _villain_defeated():
	SignalBus.villain_defeated.emit()

func signal_setup():
	SignalBus.power_end.connect(_effect_villian)
	SignalBus.turn_end.connect(_villain_turn)

func debug_commands():
	if Input.is_action_just_pressed("debug_villain_health_down"):
		VILLAIN_INFO.hp = 1
