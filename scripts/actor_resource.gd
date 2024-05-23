extends Resource

class_name Actor_Resource

@export var name : String
@export var hp_max = 10
@export var hp = hp_max
var block = 0
var energy = 0
@export var sprite = preload("res://sprites/overload_big.png")


#func _effect(power_name):
	#pass

func gain_block(block_increase):
	block += block_increase

func take_damage(attack):
	if block > 0:
		while block > 0 and attack > 0:
			block -= 1
			attack -= 1
	
	hp -= attack

func signal_setup_actor():
	pass
