extends RigidBody2D
class_name symbol_parent

@export var damage = 0
@export var block = 0.0
@export var energize = 0
@export var super_power = false 
@export var magnet_chance = 0
@onready var radius = $CollisionShape2D.shape.radius
@onready var area_2d = $Area2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var SYMBOL_PARENT = get_parent()
var BOUNCY_PEG = load("res://Scenes/Symbols/bouncy_peg.tscn")
var ball_lightning_count = 3
var SymbolManager = load("res://Scenes/Symbols/Symbol_manager.gd")
var barricade = false
var thorns = false
var speed_demon = false
@onready var speed_demon_timer = get_parent().get_node("Speed_demon_timer")
var symbol_type

func _ready():
	#collision_shape_2d.disabled = true
	SignalBus.turn_end.connect(_delete)
	speed_demon_timer.timeout.connect(_speed_demon_disable)
	symbol_type = Global.symbol_type.BRAWL

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and SYMBOL_PARENT.can_spawn:
				if event.position.distance_to(global_position) < radius and not symbol_type == 3:
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
					Global.combo.append(symbol_type)
					SignalBus.clicked.emit(symbol_type)
					if SYMBOL_PARENT.ball_lightning:
						_chain_lightning(ball_lightning_count)
					else:
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
	queue_free()

func _barricade():
	if not barricade: return
	print(block)
	block /= 5
	print(block)
	SignalBus.clicked.emit(symbol_type)

func _speed_demon_disable():
	speed_demon = false
