extends Control

func _play():
	get_tree().change_scene_to_file("res://scenes/fight_scene.tscn")

func _tutorial():
	get_tree().change_scene_to_file("res://scenes/Tutorial/tutorial.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_windowed_toggled(toggled_on):
	if (toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN, 0)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED, 0)
