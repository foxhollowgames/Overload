extends Node

@onready var color_rect = $ScreenFlash
@onready var animation_player = $ScreenFlash/AnimationPlayer
@onready var camera_2d = $Camera2D
var screen_shake = false

const PLAYER_INFO = preload("res://resources/player_info.tres")
const VILLAIN_INFO = preload("res://resources/VILLAIN_INFO.tres")

@export var player_hp_label : Label
@export var player_hp_progress_bar : ProgressBar
@export var player_block_label : Label
@export var energy : Label

@export var villain_hp_label : Label
@export var villain_hp_progress_bar : ProgressBar
@export var villain_block_label : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	signal_setup()
	player_hp_label.text = str(PLAYER_INFO.hp)
	player_hp_progress_bar.max_value = PLAYER_INFO.hp_max
	player_hp_progress_bar.value = PLAYER_INFO.hp
	player_block_label.text = str(PLAYER_INFO.block)
	energy.text = str(PLAYER_INFO.energy)
	
	villain_hp_label.text = str(VILLAIN_INFO.hp)
	villain_hp_progress_bar.max_value = VILLAIN_INFO.hp_max
	villain_hp_progress_bar.value = VILLAIN_INFO.hp
	villain_block_label.text = str(VILLAIN_INFO.block)

func screen_vfx(power_name):
	animation_player.play("FullScreenFlash")
	screen_shake = true;
	var tween := get_tree().create_tween()
	tween.tween_property(camera_2d, "offset", Vector2(randi_range(-3, -5), randi_range(1, 3)), 0.1).set_trans(Tween.TRANS_SPRING)
	tween.parallel().tween_property(camera_2d, "zoom", Vector2(randf_range(1.01, 1.02), randf_range(1.01, 1.02)), .1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(camera_2d, "offset", Vector2(0, 0), 0.1).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(camera_2d, "zoom", Vector2(1, 1), 0.1).set_trans(Tween.TRANS_SPRING)

func signal_setup():
	SignalBus.power.connect(screen_vfx)
