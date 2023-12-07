extends Node

var cur_att = false

var cur_scenes = "world"
var transition_scene1 = false
var transition_scene2 = false
var transition_scene3 = false
var transition_scene4 = false

var player_exit_cliffbawah_posx = 873
var player_exit_cliffbawah_posy = 620
var player_exit_cliffside_posx = 1134
var player_exit_cliffside_posy = 99
var player_exit_cliffkiri_posx = 20
var player_exit_cliffkiri_posy = 594
var player_start_posx = 10
var player_start_posy = 140

var first_loading = true
var bawah_loading = true
var side_loading = true
var kiri_loading = true

var progress_point = 1180
var potion_ingredient = 6

func finish_changescenes():
	if transition_scene1 == true:
		transition_scene1 = false
		if cur_scenes == "world":
			cur_scenes = "cliff_side"
		else:
			cur_scenes = "world"
	
	if transition_scene2 == true:
		transition_scene2 = false
		if cur_scenes == "world":
			cur_scenes = "cliff_bawah"
		else:
			cur_scenes = "world"
			
	if transition_scene3 == true:
		transition_scene3 = false
		if cur_scenes == "world":
			cur_scenes = "cliff_kiri"
		else:
			cur_scenes = "world"
	
	if transition_scene4 == true:
		transition_scene4 = false
		if cur_scenes == "world" or cur_scenes == "cliff_side" or cur_scenes == "cliff_bawah" or cur_scenes == "cliff_kiri":
			cur_scenes = "boss_fight"
		
