extends TextureButton

const SLIDE_2 = "res://Scenes/Tutorial/slide_2.tscn"
const SLIDE_3 = "res://Scenes/Tutorial/slide_3.tscn"
const SLIDE_4 = "res://Scenes/Tutorial/slide_4.tscn"
const SLIDE_5 = "res://Scenes/Tutorial/slide_5.tscn"
const SLIDE_6 = "res://Scenes/Tutorial/slide_6.tscn"
const SLIDE_7 = "res://Scenes/Tutorial/slide_7.tscn"
const SLIDE_8 = "res://Scenes/Tutorial/slide_8.tscn"
var screen_array = [SLIDE_2, SLIDE_3, SLIDE_4, SLIDE_5, SLIDE_6, SLIDE_7, SLIDE_8]

func _on_pressed():
	get_tree().change_scene_to_file(SLIDE_2)#if screen_array.is_empty():
	
		#return
	#texture_normal = screen_array[0]
	#screen_array.pop_front()
