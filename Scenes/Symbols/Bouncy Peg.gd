extends StaticBody2D
@onready var area_2d = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Bounce peg handling // HOW DO WE IMPART FORCE ON A SYMBOL THAT COLLIDES WITH US??
func _bounce():
	var _overlapping = area_2d.get_overlapping_bodies()
	#draw_line(Vector2.ZERO, Vector2(_overlapping[0].position.x, _overlapping[0].position.y), Color.AQUA, 2)


func _on_area_2d_area_entered(area):
	var _overlapping = area_2d.get_overlapping_bodies()
	#draw_line(Vector2.ZERO, Vector2(_overlapping[0].position.x, _overlapping[0].position.y), Color.AQUA, 2)
