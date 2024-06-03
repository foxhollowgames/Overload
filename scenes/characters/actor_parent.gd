extends Node2D
class_name actor

@export var actor_info: ActorResource

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
var PLAYER_INFO = preload("res://resources/player_info.tres")
var VILLAIN_INFO = preload("res://resources/villain_info.tres")

## Called when the node enters the scene tree for the first time.
func _ready():
	#signal_setup_actor()
	pass

#func _effect(power_name):
	#pass

#func gain_block(block_increase, id):
	#id.block += id.block_increase
	#id.block_label.text = str(block)
#
#func deal_damage(attack):
	#if block > 0:
		#while block > 0 and attack > 0:
			#block -= 1
			#attack -= 1
	#block_label.text = str(block)
	#
	#hp -= attack
	#hp_label.text = str(hp)
	#hp_progress_bar_max.max_value = hp_max
	#hp_progress_bar_current.value = hp
	#animation_player.play("take_damage")

func squish_squash():
	#DUNNY
	var tween := get_tree().create_tween()
	tween.tween_property(animated_sprite_2d, "scale", Vector2(randf_range(1.05, 1.2), randf_range(1.2, 1.3)), 0.3)
	tween.tween_property(animated_sprite_2d, "scale", Vector2(1, 1), 0.1)

func signal_setup_actor():
	pass