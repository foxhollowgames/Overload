extends Node2D
class_name characte

@export var hp_max = 10
@export var hp = hp_max
@export var hp_label : Label
@export var hp_progress_bar_max : ProgressBar
@export var hp_progress_bar_current : ProgressBar
var block = 0
@export var block_label : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	hp_label.text = str(hp)
	hp_progress_bar_max.max_value = hp_max
	hp_progress_bar_current.value = hp
	block_label.text = str(block)

#func _effect(power_name):
	#pass

func _block(block_increase):
	block += block_increase
	block_label.text = str(block)

func _damage(attack):
	if block > 0:
		while block > 0 and attack > 0:
			block -= 1
			attack -= 1
	block_label.text = str(block)
	
	hp -= attack
	hp_label.text = str(hp)
	hp_progress_bar_max.max_value = hp_max
	hp_progress_bar_current.value = hp
