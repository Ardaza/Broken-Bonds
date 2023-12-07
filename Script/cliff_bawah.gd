extends Node2D

func _process(delta):
	change_scene()  

func _on_kembali_body_entered(body):
	if body.has_method("player"):
		global.transition_scene2 = true

func _on_kembali_body_exited(body):
	if body.has_method("player"):
		global.transition_scene2 = false

func change_scene():
	if global.transition_scene2 == true:
		if global.cur_scenes == "cliff_bawah":
			get_tree().change_scene_to_file("res://Scene/world.tscn")
			global.finish_changescenes()
