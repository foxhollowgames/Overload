extends TextureButton
const SLIDE_2 = preload("res://Scenes/Tutorial/Slide_2.png")
const SLIDE_03 = preload("res://Scenes/Tutorial/slide_03.png")
const SLIDE_04 = preload("res://Scenes/Tutorial/slide_04.png")
const SLIDE_05 = preload("res://Scenes/Tutorial/slide_05.png")
const SLIDE_06 = preload("res://Scenes/Tutorial/slide_06.png")
const SLIDE_07 = preload("res://Scenes/Tutorial/slide_07.png")
const SLIDE_8 = preload("res://Scenes/Tutorial/Slide_8.png")
var screen_array = [SLIDE_2, SLIDE_03, SLIDE_04, SLIDE_05, SLIDE_06, SLIDE_07, SLIDE_8]

func _on_pressed():
	if screen_array.is_empty():
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		return
	texture_normal = screen_array[0]
	screen_array.pop_front()
