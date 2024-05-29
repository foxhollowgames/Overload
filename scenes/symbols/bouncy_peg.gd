extends StaticBody2D
@onready var area_2d = $Area2D


# Bounce peg handling // HOW DO WE IMPART FORCE ON A SYMBOL THAT COLLIDES WITH US??
func _bounce():
	var _overlapping = area_2d.get_overlapping_bodies()
	#draw_line(Vector2.ZERO, Vector2(_overlapping[0].position.x, _overlapping[0].position.y), Color.AQUA, 2)


func _on_area_2d_area_entered(_area):
	var _overlapping = area_2d.get_overlapping_bodies()
	#draw_line(Vector2.ZERO, Vector2(_overlapping[0].position.x, _overlapping[0].position.y), Color.AQUA, 2)
