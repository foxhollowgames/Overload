extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	for timer in get_children():
		timer.wait_time = randf_range(.1, .5)
