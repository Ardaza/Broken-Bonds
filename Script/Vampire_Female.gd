extends CharacterBody2D

var kecepatan = 70
var kejar = false
var player = null

var darah = 40
var att_zone = false
var can_take_damage = true

func _physics_process(delta):
	deal_with_damage()
	update_health()
	
	if kejar:
		position += (player.position - position)/kecepatan
		
		
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x)<0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
	else:
		$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body):
	player = body
	kejar = true

func _on_detection_area_body_exited(body):
	player = null
	kejar = false
	
func enemy():
	pass

func _on_enemy_hit_box_body_entered(body):
	if body.has_method("player"):
		att_zone = true

func _on_enemy_hit_box_body_exited(body):
	if body.has_method("player"):
		att_zone = false
		
func deal_with_damage():
	if att_zone and global.cur_att == true:
		if can_take_damage == true:
			darah = darah - 10
			$take_damage_cd.start()
			can_take_damage = false
			print("Darah Vampire: ", darah)
			if darah <= 0:
				
				self.queue_free()
				
func _on_take_damage_cd_timeout():
	can_take_damage = true
	
func update_health():
	var bardarah = $Health_Bar
	bardarah.value = darah
	
	if darah >= 40:
		bardarah.visible = false
	else:
		bardarah.visible = true
