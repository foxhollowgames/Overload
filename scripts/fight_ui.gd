extends Node

@onready var color_rect = $ScreenFlash
@onready var animation_player = $ScreenFlash/AnimationPlayer
@onready var camera_2d = $Camera2D
var screen_shake = false

const PLAYER_INFO = preload("res://resources/player_info.tres")
const VILLAIN_INFO = preload("res://resources/villain_info.tres")

@export var player_hp_label : Label
@export var player_hp_progress_bar : ProgressBar
@export var player_block_label : Label
@export var energy : Label

@export var villain_hp_label : Label
@export var villain_hp_progress_bar : ProgressBar
@export var villain_block_label : Label
@export var intention_value_label : Label
@export var intention_label : Label

# Powers
# TODO: Make dynamically loaded through a resource or smthng
@onready var power_chain_lightning = $Powers/PowerChainLightning
@onready var power_static_shield = $Powers/PowerStaticShield
@onready var power_shock = $Powers/PowerShock
@onready var power_energize = $Powers/PowerEnergize
@onready var power_block = $Powers/PowerBlock
@onready var power_brawl = $Powers/PowerBrawl
@onready var power_array = [power_chain_lightning, power_static_shield, power_shock, power_energize, power_block, power_brawl]

# Called when the node enters the scene tree for the first time.
func _ready():
	signal_setup()
	update_ui()
	
func _process(_delta):
	pass

func screen_vfx(_power_name):
	# TODO: Adjust this to be dynamic to the type of effect happening (IE: More damage = screenshake, healing = green flash instead of white, etc)
	animation_player.play("FullScreenFlash")
	screen_shake = true;
	var tween := get_tree().create_tween()
	tween.tween_property(camera_2d, "offset", Vector2(randi_range(-3, -5), randi_range(1, 3)), 0.1).set_trans(Tween.TRANS_SPRING)
	tween.parallel().tween_property(camera_2d, "zoom", Vector2(randf_range(1.01, 1.02), randf_range(1.01, 1.02)), .1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(camera_2d, "offset", Vector2(0, 0), 0.1).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(camera_2d, "zoom", Vector2(1, 1), 0.1).set_trans(Tween.TRANS_SPRING)
	tween.tween_callback(update_ui)

func update_ui():
	player_hp_label.text = str(PLAYER_INFO.hp)
	player_hp_progress_bar.max_value = PLAYER_INFO.hp_max
	player_hp_progress_bar.value = PLAYER_INFO.hp
	player_block_label.text = str(PLAYER_INFO.block)
	energy.text = str(PLAYER_INFO.energy)
	
	villain_hp_label.text = str(VILLAIN_INFO.hp)
	villain_hp_progress_bar.max_value = VILLAIN_INFO.hp_max
	villain_hp_progress_bar.value = VILLAIN_INFO.hp
	villain_block_label.text = str(VILLAIN_INFO.block)
	match VILLAIN_INFO.intention:
		"attack":
			#TODO: Add ICONS
			intention_value_label.text = VILLAIN_INFO.attack.value
			intention_label.text = "Attack"
		"block":
			intention_value_label.text = VILLAIN_INFO.block.value
			intention_label.text = "Block"
		"interfere":
			intention_label.text = "Interfere"
		"buff":
			intention_label.text = "Buff"
		"debuff":
			intention_label.text = "Debuff"

# Check if there is ANY power active, and if not, clear the state
func _is_power_active(power_name):
	var is_active = false
	
	for _i in power_array.size():
		if power_array[_i].active:
			is_active = true
	
	if not is_active:
		SignalBus.clear_combo.emit(power_name)


func signal_setup():
	SignalBus.power.connect(screen_vfx)
	SignalBus.power_end.connect(update_ui)
	SignalBus.clicked.connect(_is_power_active)
