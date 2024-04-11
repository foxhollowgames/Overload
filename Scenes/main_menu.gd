extends Control

func _play():
	get_tree().change_scene_to_file("res://Scenes/fight_scene.tscn")

func _tutorial():
	get_tree().change_scene_to_file("res://Scenes/Tutorial/tutorial.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_windowed_toggled(toggled_on):
	if (toggled_on):
		DisplayServer.window_set_mode(3, 0)
	else:
		DisplayServer.window_set_mode(0, 0)
