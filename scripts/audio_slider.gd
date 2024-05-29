extends HSlider

@export var master_bus := "Master"

@onready var _bus := AudioServer.get_bus_index(master_bus)

# Called when the node enters the scene tree for the first time.
func _ready():
	value = db_to_linear(AudioServer.get_bus_volume_db(_bus))

func _on_value_changed(change):
	AudioServer.set_bus_volume_db(_bus, linear_to_db(change))
	print(AudioServer.get_bus_volume_db(_bus))
