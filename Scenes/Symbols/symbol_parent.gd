extends RigidBody2D
class_name symbol_parent

@onready var radius = $CollisionShape2D.shape.radius
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var symbol_manager = get_parent()
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

@onready var speed_demon_timer = get_parent().get_parent().get_node("Timers/SpeedDemonTimer")
var symbol_type
@onready var click_sound = $ClickSound
var clicked = false

# Deprecated variables
@export var damage = 0
@export var block = 0.0
@export var energize = 0
@export var magnet_chance = 0
var BOUNCY_PEG = load("res://scenes/symbols/bouncy_peg.tscn")
var ball_lightning_count = 3

var barricade = false
var thorns = false
var speed_demon = false
# area_2d was for chain lightning which has been removed from the game
@export var super_power = false 
@onready var area_2d = $Area2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D

func _ready():
	signal_setup()
	symbol_type = Global.symbol_type.BRAWL

func _unhandled_input(event):
	if clicked:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and symbol_manager.can_spawn:
		if event.position.distance_to(global_position) < radius and not symbol_type == 3:
			click_sound.pitch_scale = randf_range(0.8, 1.2)
			click_sound.play()
			if speed_demon:
				block *= 2
				damage *= 2
				energize *= 2
			if thorns:
				print(Global.thorns_count)
				Global.thorns_count += 1
				if Global.thorns_count >= 3:
					damage += 1
					print(damage)
					Global.thorns_count = 0
			clicked = true
			Global.combo.append(symbol_type)
			SignalBus.clicked.emit(symbol_type)
			clicked_vfx()
			#if symbol_manager.ball_lightning:
				#_chain_lightning(ball_lightning_count)
			#else:
			_delete()

func _chain_lightning(count):
	if count <= 0:
		return
	var _overlapping = area_2d.get_overlapping_bodies()
	if not _overlapping:
		return

	var _i = _overlapping.pop_front()
	if _i is symbol_parent:
		_i._chain_lightning(count - 1)
		_delete()

func _delete():
	var tween = create_tween()
	#TODO: Replace with dissolving shader
	tween.tween_property(sprite_2d, "scale:x", 0, .3)
	tween.tween_callback(queue_free)

func _barricade():
	if not barricade: return
	print(block)
	block /= 5
	print(block)
	SignalBus.clicked.emit(symbol_type)

func _speed_demon_disable():
	speed_demon = false

func signal_setup():
	SignalBus.turn_end.connect(_delete)
	speed_demon_timer.timeout.connect(_speed_demon_disable)

func clicked_vfx():
	var tween := get_tree().create_tween()
	tween.tween_property(self, "gravity_scale", 0, 0).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "constant_force", Vector2(randi_range(-2500, 2500), randi_range(-5000, -5000)), 1).set_trans(Tween.TRANS_BOUNCE)
	
	var vfx_array = Array(animated_sprite_2d.sprite_frames.get_animation_names())
	vfx_array.erase("idle")
	var random_animation = vfx_array.pick_random()
	animated_sprite_2d.self_modulate.a = .75
	var color = Vector4(1.0, 1.0, 1.0, 1.0)
	match symbol_type:
		Global.symbol_type.BRAWL:
			color = Vector4(0.95, 0.28, 0.13, 1.0)
		Global.symbol_type.BLOCK:
			color = Vector4(13.0/255, 153.0/255, 255.0/255, 1.0)
		Global.symbol_type.ENERGIZE:
			color = Vector4(255.0/255, 205.0/255, 41.0/255, 1.0)
		Global.symbol_type.SUPER_POWER:
			color = Vector4(255.0/255, 0.0/255, 214.0/255, 1.0)
	#print("Symbol Color: " + str(animated_sprite_2d.material.get_shader_parameter("symbol_color")))
	animated_sprite_2d.material.set_shader_parameter("symbol_color", color)
	#print("Symbol Color: " + str(animated_sprite_2d.material.get_shader_parameter("symbol_color")))
	if (randi_range(0, 1)):
		animated_sprite_2d.flip_h
	if (randi_range(0, 1)):
		animated_sprite_2d.flip_v
	animated_sprite_2d.play(random_animation)

	animation_player.play("click_flash")
