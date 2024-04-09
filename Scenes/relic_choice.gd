extends Node2D

var fight_scene = load("res://Scenes/fight_scene_2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.relic_picked.connect(_fight)
	print("Fight connected!")

func _fight(title):
	print("GO to fight!")
	get_tree().change_scene_to_packed(fight_scene)
