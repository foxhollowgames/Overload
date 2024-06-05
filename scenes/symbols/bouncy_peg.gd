extends StaticBody2D
@onready var area_2d = $Area2D

func _bounce():
	var _overlapping = area_2d.get_overlapping_bodies()

func _on_area_2d_area_entered(_area):
	var _overlapping = area_2d.get_overlapping_bodies()
