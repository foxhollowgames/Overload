extends "res://scenes/Tutorial/TextureButton.gd"

func _on_pressed():
	get_tree().change_scene_to_file()
