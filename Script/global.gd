extends Node

var cur_att = false


var cur_scenes = "world"
var transition_scene1 = false
var transition_scene2 = false

var player_exit_cliffbawah_posx = 873
var player_exit_cliffbawah_posy = 649
var player_exit_cliffside_posx = 1141
var player_exit_cliffside_posy = 99
var player_start_posx = 10
var player_start_posy = 140

var first_loading = true
var bawah_loading = true
var side_loading = true

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
