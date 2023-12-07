extends Node2D

func _process(delta):
	change_scene()
	change_scene4()
	goals_achieved()

func goals_achieved():
	if global.progress_point == 1200 and global.potion_ingredient == 6:
		global.transition_scene4 = true

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
			global.kiri_loading = true
			global.finish_changescenes()

func change_scene4():
	if global.transition_scene4 == true:
		get_tree().change_scene_to_file("res://Scene/boss_fight.tscn")
		global.first_loading = false
		global.side_loading = false
		global.bawah_loading = false
		global.kiri_loading = false
		global.finish_changescenes()
