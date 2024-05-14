extends Node2D

@onready var transition_audio = $Audio/RelicTransition

# Scene transitions
#var game_over : = "res://Scenes/game_over.tscn"
#var game_end = "res://Scenes/game_end.tscn"
#var relic_choice_scene : = "res://Scenes/relic_choice.tscn"
var turn_start_ui = load("res://scenes/turn_start_ui.tscn")

func _ready():
	signal_setup()

func _turn_ini():
	add_child(turn_start_ui.instantiate())

func villain_defeated():
	transition_audio.play()
	await get_tree().create_timer(2).timeout
	#get_tree().change_scene_to_file(relic_choice_scene)
	get_tree().change_scene_to_file("res://Scenes/game_end.tscn")

func signal_setup():
	SignalBus.villain_turn_end.connect(_turn_ini)
	SignalBus.villain_defeated.connect(villain_defeated)

