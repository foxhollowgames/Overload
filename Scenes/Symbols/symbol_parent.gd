extends RigidBody2D
class_name symbol_parent

@onready var radius = $CollisionShape2D.shape.radius

@onready var symbol_manager = get_parent()

@onready var speed_demon_timer = get_parent().get_parent().get_node("Timers/SpeedDemonTimer")
var symbol_type
@onready var click_sound = $ClickSound
var clicked = false

# Deprecated variables
@export var damage = 0
@export var block = 0.0
@export var energize = 0
@export var magnet_chance = 0
var BOUNCY_PEG = load("res://Scenes/Symbols/bouncy_peg.tscn")
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
	tween.tween_property(self, "scale:x", 0, .1)
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
