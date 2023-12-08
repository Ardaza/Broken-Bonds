extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if global.boss_loading == true:
		$Player.position.x = global.player_start_boss_posx
		$Player.position.y = global.player_start_boss_posy

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
