extends "res://Scenes/Tutorial/TextureButton.gd"

func _on_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
