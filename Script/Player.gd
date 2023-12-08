extends CharacterBody2D

var range = false
var att_cd = true
var darah = 100
var alive = true

var attack_ip = false

var multiplier = 0

var dwarf_king = false
var kang_grot = false
var elf_lord = false

var have_moved = false

@onready var pukul = $Pukul
@onready var kena = $kena
@onready var mati = $mati

const speed = 100
var directions = "none"

func _physics_process(delta):
	check_alive()
	playerMovement(delta)
	enemy_att()
	attack()
	curent_camera()
	update_health()
	
	if dwarf_king == true:
		if Input.is_action_just_pressed("ui_accept"):
			DialogueManager.show_example_dialogue_balloon(load("res://Glodon.dialogue"), "start")
			return 
	
	if kang_grot == true:
		if Input.is_action_just_pressed("ui_accept"):
			DialogueManager.show_example_dialogue_balloon(load("res://Lomort.dialogue"), "start")
			return 
			
	if elf_lord == true:
		if Input.is_action_just_pressed("ui_accept"):
			DialogueManager.show_example_dialogue_balloon(load("res://Talon.dialogue"), "start")
			return
	
	if darah <= -50:
		self.queue_free()
		have_moved = false
		multiplier = 0
		global.progress_point = 0
		
		if global.cur_scenes == 'world':
			get_tree().change_scene_to_file("res://Scene/world.tscn")
			global.bawah_loading = false
			global.side_loading = false
			global.kiri_loading = false
			global.finish_changescenes()
			alive == true
			
		if global.cur_scenes == 'cliff_side':
			get_tree().change_scene_to_file("res://Scene/cliff_side.tscn")
			global.first_loading = false
			global.bawah_loading = false
			global.kiri_loading = false
			global.finish_changescenes()
			alive == true
		
		if global.cur_scenes == 'cliff_kiri':
			get_tree().change_scene_to_file("res://Scene/cliff_kiri.tscn")
			global.first_loading = false
			global.bawah_loading = false
			global.side_loading = false
			global.finish_changescenes()
			alive == true
			
		if global.cur_scenes == 'cliff_bawah':
			get_tree().change_scene_to_file("res://Scene/cliff_bawah.tscn")
			global.first_loading = false
			global.side_loading = false
			global.kiri_loading = false
			global.finish_changescenes()
			alive == true
	
func playerMovement(delta):
	
	if Input.is_action_pressed("ui_right"):
		directions = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
		have_moved = true
	elif Input.is_action_pressed("ui_left"):
		directions = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
		have_moved = true
	elif Input.is_action_pressed("ui_down"):
		directions = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
		have_moved = true
	elif Input.is_action_pressed("ui_up"):
		directions = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
		have_moved = true
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

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		multiplier -= 1
		range = false
		
	if body.has_method("Vampire_Female"):
		multiplier -= 1
		range = false
		
	if body.has_method("dwarf_king"):
		dwarf_king = false
		
	if body.has_method("kang_grot"):
		kang_grot = false
		
	if body.has_method("elf_lord"):
		elf_lord = false

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		multiplier += 1
		range = true
		
	if body.has_method("Vampire_Female"):
		multiplier += 1
		range = true
	
	if body.has_method("dwarf_king"):
		dwarf_king = true
		
	if body.has_method("kang_grot"):
		kang_grot = true
		
	if body.has_method("elf_lord"):
		elf_lord = true

func enemy_att():
	if range and att_cd == true:
		kena.play()
		darah -= 10 * multiplier
		att_cd = false
		$Att_cd.start()
		print(darah)
		

func _on_att_cd_timeout():
	att_cd = true

func attack():
	var dir = directions
	if  alive == true and have_moved == true and global.cur_att == false and Input.is_action_just_pressed("attack"):
		print("Attacking")
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
		$Cliff_kiri_camera.enabled = false
	elif global.cur_scenes == "cliff_bawah":
		$World.enabled = false
		$Cliff_bawah_camera.enabled = true
		$Cliff_side_camera.enabled = false
		$Cliff_kiri_camera.enabled = false
	elif global.cur_scenes == "cliff_side":
		$World.enabled = false
		$Cliff_bawah_camera.enabled = false
		$Cliff_side_camera.enabled = true
		$Cliff_kiri_camera.enabled = false
	elif global.cur_scenes == "cliff_kiri":
		$World.enabled = false
		$Cliff_bawah_camera.enabled = false
		$Cliff_side_camera.enabled = false
		$Cliff_kiri_camera.enabled = true
		

func update_health():
	var bardarah = $Health_Bar
	bardarah.value = darah
	
	if darah >= 100:
		bardarah.visible = false
	else:
		bardarah.visible = true

func _on_regen_timeout():
	if darah > 0 and darah < 100:
		darah += 20
		if darah > 100:
			darah = 100

func check_alive():
	if darah <= 0:
		$deal_att_timer.stop()
		global.cur_att = false
		attack_ip = false
		alive == false
		darah = -100
