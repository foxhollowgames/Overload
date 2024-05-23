extends "res://scenes/Symbols/Symbol_manager.gd"

func _villain_defeated():
	get_tree().change_scene_to_file(game_end)
