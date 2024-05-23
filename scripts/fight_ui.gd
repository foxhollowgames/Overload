extends Node

@onready var color_rect = $ScreenFlash
@onready var animation_player = $ScreenFlash/AnimationPlayer
@onready var camera_2d = $Camera2D
var screen_shake = false

@export var player_info: Actor_Resource
@export var villain_info: Actor_Resource

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
	player_hp_label.text = str(player_info.hp)
	player_hp_progress_bar.max_value = player_info.hp_max
	player_hp_progress_bar.value = player_info.hp
	player_block_label.text = str(player_info.block)
	energy.text = str(player_info.energy)
	
	villain_hp_label.text = str(villain_info.hp)
	villain_hp_progress_bar.max_value = villain_info.hp_max
	villain_hp_progress_bar.value = villain_info.hp
	villain_block_label.text = str(villain_info.block)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("Flash.a: " + str(color_rect.color.a))
	pass

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
