extends Node

@onready var color_rect = $ScreenFlash
@onready var animation_player = $ScreenFlash/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	signal_setup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("Flash.a: " + str(color_rect.color.a))
	pass

func screen_vfx(symbol_type):
	animation_player.play("FullScreenFlash")

func signal_setup():
	SignalBus.clicked.connect(screen_vfx)
