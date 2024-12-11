extends CanvasLayer


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/tic_tac_toe.tscn")



func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
