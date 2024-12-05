extends Control




func _on_p_pressed():
	get_tree().change_scene_to_file("res://Scenes/tic_tac_toe.tscn")



func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
