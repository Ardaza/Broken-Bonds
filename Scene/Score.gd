extends Label


func _ready():
	update()

func _process(delta):
	update()

func update():
	text = "SCORE " + str(global.progress_point)
