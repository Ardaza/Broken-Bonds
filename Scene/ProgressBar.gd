extends ProgressBar

func _process(delta):
	update()

func update():
	value = global.progress_point
