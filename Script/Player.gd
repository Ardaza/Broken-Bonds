extends CharacterBody2D

var range = false
var att_cd = true
var darah = 150
var alive = true

var attack_ip = false

var npc_in_range = false

@onready var pukul = $Pukul
@onready var kena = $kena
@onready var mati = $mati

const speed = 70
var directions = "none"

func _physics_process(delta):
	playerMovement(delta)
	enemy_att()
	attack()
	curent_camera()
	update_health()
	
	if npc_in_range == true:
		if Input.is_action_just_pressed("ui_accept"):
			scale.x *= 0.3
			scale.y *= 0.3
			DialogueManager.show_example_dialogue_balloon(load("res://Globon.dialogue"), "start")
			return 
	
	if darah <= 0:
		self.queue_free()
		if global.cur_scenes == 'world':
			get_tree().change_scene_to_file("res://Scene/world.tscn")
			global.bawah_loading = false
			global.side_loading = false
			global.finish_changescenes()
			
		if global.cur_scenes == 'cliff_side':
			get_tree().change_scene_to_file("res://Scene/cliff_side.tscn")
			global.bawah_loading = false
			global.first_loading = false
			global.finish_changescenes()
			
		if global.cur_scenes == 'cliff_bawah':
			get_tree().change_scene_to_file("res://Scene/cliff_bawah.tscn")
			global.side_loading = false
			global.first_loading = false
			global.finish_changescenes()
	
func playerMovement(delta):
	
	if Input.is_action_pressed("ui_right"):
		directions = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		directions = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		directions = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		directions = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		velocity.x = 0
		velocity.y = 0
		play_anim(0)
	
	move_and_slide()
	
func play_anim(movement):
	var dir = directions
	var animation = $AnimatedSprite2D
	
	if dir == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("Side_Walk")
		elif movement == 0:
			if attack_ip == false:
				animation.play("Side_Idle")
			
	if dir == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("Side_Walk")
		elif movement == 0:
			if attack_ip == false:
				animation.play("Side_Idle")
			
	if dir == "up":
		if movement == 1:
			animation.play("Back_Walk")
		elif movement == 0:
			if attack_ip == false:
				animation.play("Back_Idle")
	
	if dir == "down":
		if movement == 1:
			animation.play("Front_Walk")
		elif movement == 0:
			if attack_ip == false:
				animation.play("Front_Idle")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		range = true
	
	if body.has_method("npc"):
		npc_in_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		range = false
		
	if body.has_method("npc"):
		npc_in_range = false
		
func enemy_att():
	if range and att_cd == true:
		kena.play()
		darah = darah - 10
		att_cd = false
		$Att_cd.start()
		print(darah)

func _on_att_cd_timeout():
	att_cd = true

func attack():
	var dir = directions
	if Input.is_action_just_pressed("attack"):
		pukul.play()
		global.cur_att = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("Side_Att")
			$deal_att_timer.start()
			
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("Side_Att")
			$deal_att_timer.start()
			
		if dir == "down":
			$AnimatedSprite2D.play("Front_Att")
			$deal_att_timer.start()
			
		if dir == "up":
			$AnimatedSprite2D.play("Back_Att")
			$deal_att_timer.start()
			

func _on_deal_att_timer_timeout():
	$deal_att_timer.stop()
	global.cur_att = false
	attack_ip = false
	
func curent_camera():
	if global.cur_scenes == "world":
		$World.enabled = true
		$Cliff_bawah_camera.enabled = false
		$Cliff_side_camera.enabled = false
	elif global.cur_scenes == "cliff_bawah":
		$World.enabled = false
		$Cliff_bawah_camera.enabled = true
		$Cliff_side_camera.enabled = false
	elif global.cur_scenes == "cliff_side":
		$World.enabled = false
		$Cliff_bawah_camera.enabled = false
		$Cliff_side_camera.enabled = true
		

func update_health():
	var bardarah = $Health_Bar
	bardarah.value = darah
	
	if darah >= 150:
		bardarah.visible = false
	else:
		bardarah.visible = true

func _on_regen_timeout():
	if darah < 150:
		darah += 10
		if darah > 150:
			darah = 150
	if darah <= 0:
		darah = 0
