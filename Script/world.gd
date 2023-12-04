extends Node2D

# Called when the node enters the scene tree for the first time.
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene1()
	change_scene2()

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
			global.finish_changescenes()
