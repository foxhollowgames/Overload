extends Resource
class_name ActorResource

@export var name = "Overload"
@export var sprite = preload("res://sprites/characters/Overload-Sheet.png")
@export var hp_max = 10
@export var hp = hp_max
@export var block = 1
@export var energy = 0

func gain_block(block_increase):
	block += block_increase

func take_damage(attack):
	if block > 0:
		while block > 0 and attack > 0:
			block -= 1
			attack -= 1
	
	hp -= attack
	print_debug("Block: " + str(block))
	print_debug("hp: " + str(hp))
