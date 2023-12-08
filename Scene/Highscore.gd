extends Label

func _ready():
	update()
	
func _process(delta):
	update()
	
func update():
	if global.progress_point > global.highscore:
		global.highscore = global.progress_point
	else :
		global.highscore = global.highscore
	text = "HIGHSCORE " + str(global.highscore)
