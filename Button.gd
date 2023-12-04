extends Button

func _on_pressed():
	global.transition_scene1 == true
	global.transition_scene2 == true
	get_tree().change_scene_to_file("res://Scene/world.tscn")
