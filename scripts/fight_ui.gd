extends Node

@onready var color_rect = $ScreenFlash
@onready var animation_player = $ScreenFlash/AnimationPlayer
@onready var camera_2d = $Camera2D
var screen_shake = false

# Called when the node enters the scene tree for the first time.
func _ready():
	signal_setup()


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
