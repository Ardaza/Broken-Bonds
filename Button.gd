extends Button

func _on_pressed():
	global.transition_scene3 = true
	get_tree().change_scene_to_file("res://Scene/world.tscn")
