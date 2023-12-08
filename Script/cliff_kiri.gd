extends Node2D

func _process(delta):
	change_scene()

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		global.transition_scene3 = true

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		global.transition_scene3 = false
		
func change_scene():
	if global.transition_scene3 == true:
		if global.cur_scenes == "cliff_kiri":
			global.kiri_loading = true
			get_tree().change_scene_to_file("res://Scene/world.tscn")
			global.finish_changescenes()

