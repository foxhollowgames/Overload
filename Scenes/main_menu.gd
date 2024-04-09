extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _play():
	get_tree().change_scene_to_file("res://Scenes/fight_scene.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_windowed_toggled(toggled_on):
	if (toggled_on):
		DisplayServer.window_set_mode(3, 0)
	else:
		DisplayServer.window_set_mode(0, 0)
