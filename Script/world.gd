extends Node2D

func _ready():
	
	if global.first_loading == true:
		$Player.position.x = global.player_start_posx
		$Player.position.y = global.player_start_posy
	elif global.bawah_loading == true:
		$Player.position.x = global.player_exit_cliffbawah_posx
		$Player.position.y = global.player_exit_cliffbawah_posy
	elif global.side_loading == true:
		$Player.position.x = global.player_exit_cliffside_posx
		$Player.position.y = global.player_exit_cliffside_posy
	elif global.kiri_loading == true:
		$Player.position.x = global.player_exit_cliffkiri_posx
		$Player.position.y = global.player_exit_cliffkiri_posy

func _process(delta):
	change_scene1()
	change_scene2()
	change_scene3()
	change_scene4()
	goals_achieved()

func _on_cliff_side_body_entered(body):
	if body.has_method("player"):
		global.transition_scene1 = true

func _on_cliff_side_body_exited(body):
	if body.has_method("player"):
		global.transition_scene1 = false

func change_scene1():
	if global.transition_scene1 == true:
		if global.cur_scenes == 'world':
			get_tree().change_scene_to_file("res://Scene/cliff_side.tscn")
			global.first_loading = false
			global.bawah_loading = false
			global.kiri_loading = false
			global.finish_changescenes()

func _on_cliff_bawah_body_entered(body):
	if body.has_method("player"):
		global.transition_scene2 = true

func _on_cliff_bawah_body_exited(body):
	if body.has_method("player"):
		global.transition_scene2 = false
		
func change_scene2():
	if global.transition_scene2 == true:
		if global.cur_scenes == 'world':
			get_tree().change_scene_to_file("res://Scene/cliff_bawah.tscn")
			global.first_loading = false
			global.side_loading = false
			global.kiri_loading = false
			global.finish_changescenes()


func _on_cliff_kiri_body_entered(body):
	if body.has_method("player"):
		global.transition_scene3 = true


func _on_cliff_kiri_body_exited(body):
	if body.has_method("player"):
		global.transition_scene3 = false
	
func change_scene3():
	if global.transition_scene3 == true:
		if global.cur_scenes == 'world':
			get_tree().change_scene_to_file("res://Scene/cliff_kiri.tscn")
			global.first_loading = false
			global.side_loading = false
			global.bawah_loading = false
			global.finish_changescenes()

func goals_achieved():
	if global.progress_point == 1200 and global.potion_ingredient == 6:
		global.transition_scene4 = true
		print("Objective Done")

func change_scene4():
	if global.transition_scene4 == true:
		get_tree().change_scene_to_file("res://Scene/boss_fight.tscn")
		global.first_loading = false
		global.side_loading = false
		global.bawah_loading = false
		global.kiri_loading = false
		global.finish_changescenes()
