extends CharacterBody2D

var eye1 = preload("res://eyestrain/eye1.png")
var eye2 = preload("res://eyestrain/eye2.png")
var eye3 = preload("res://eyestrain/eye3.png")

var b1 = preload("res://Players/Bob/Bob1.png")
var b2 = preload("res://Players/Bob/Bob2.png")
var b3 = preload("res://Players/Bob/Bob3.png")

var c1 = preload("res://Players/Conner/Conner1.png")
var c2 = preload("res://Players/Conner/Conner2.png")
var c3 = preload("res://Players/Conner/Conner3.png")

var p1 = preload("res://Players/Paul/Paul1.png")
var p2 = preload("res://Players/Paul/Paul2.png")
var p3 = preload("res://Players/Paul/Paul3.png")

var speed = 400.0
var breathingdivide = 1
var breathingmultiply = 1
var breathingadd = 0
var breathingsubtract = 0
var breathup = 0

var unlocks = Global.unlocksname
var currentunlocked = []

var moving = false

var firsttime = true

var breathingup = false
var breathed = false
var breathingdown = false
func _ready() -> void:
	if Global.rebirth == false:
		match Global.mode:
			1:
				Global.score = 30
				Global.breath = 100.0
			2:
				Global.score = 15
				Global.breath = 100.0
			3:
				Global.score = 5
				Global.breath = 75.0
	else:
		Global.score += 5
	match Global.Player:
		"Bob":
			get_node("Sprite2D").texture = b1
			speed = 400
		"Conner":
			get_node("Sprite2D").texture = c1
			speed = 600
			breathingmultiply = 2
		"Paul":
			get_node("Sprite2D").texture = p1
			speed = 400
			breathingadd = 3


func _physics_process(delta: float) -> void:
	if firsttime == true:
		firsttime = false
		while Global.mode == 2:
			if not Input.is_action_pressed("Breath") or breathed:
				if breathingdown == false:
					get_node("Timer").start(2)
					breathingdown = true
				await get_node("Timer").timeout
				Global.breath -= randi_range((1*breathingmultiply)-breathingsubtract,(5*breathingmultiply)+breathingadd)
				breathingdown = false
			else:
				if breathingdown == false:
					get_node("Timer").start(2)
					breathingdown = true
				await get_node("Timer").timeout
				while Input.is_action_pressed("Breath") and not breathed:
					Global.breath += (1+breathup)/breathingdivide
					await get_tree().create_timer(0.1).timeout
					if Global.breath == 100.0:
						breathed = true
				breathingdown = false
			
		while Global.mode == 3:
			if get_node("Timer2").is_stopped() or Global.breath == 75.0:
				breathingup = false
				await get_tree().create_timer(0.2).timeout
				if get_node("Timer2").is_stopped() or Global.breath == 75.0:
					if breathingdown == false:
						get_node("Timer").start(2)
						breathingdown = true
					await get_node("Timer").timeout
					if get_node("Timer2").is_stopped() or Global.breath == 75.0:
						Global.breath -= randi_range((5*breathingmultiply)-breathingsubtract,(10*breathingmultiply)+breathingadd)
						breathingdown = false
			else: 
				await get_node("Timer2").timeout
				breathingup = false
			
			
			
	if not Input.is_action_pressed("Breath") and breathed == true:
		breathed = false
		
	$"../Label".text = "Breath: " + str(Global.breath)
	$"../Score".text = "Coins: " + str(Global.score)
	if Global.breath < 70 and Global.breath > 60:
		$"../strain".texture = eye1
		$"../strain".visible = true
		$"../strain".scale = Vector2(3.6,3.6)
		$"../strain".self_modulate.a = 1
	elif Global.breath < 60 and Global.breath > 50:
		$"../strain".texture = eye1
		$"../strain".visible = true
		$"../strain".scale = Vector2(3.6,3.6)
		$"../strain".self_modulate.a = 2
	elif Global.breath < 50 and Global.breath > 35:
		$"../strain".texture = eye2
		$"../strain".visible = true
		$"../strain".scale = Vector2(3.6,3.6)
		$"../strain".self_modulate.a = 4
	elif Global.breath < 35 and Global.breath > 25:
		$"../strain".texture = eye2
		$"../strain".visible = true
		$"../strain".scale = Vector2(3.6,3.6)
		$"../strain".self_modulate.a = 6
	elif Global.breath < 25 and Global.breath > 15:
		$"../strain".texture = eye3
		$"../strain".visible = true
		$"../strain".scale = Vector2(2.2,2.2)
		$"../strain".self_modulate.a = 8
	elif Global.breath < 15 and Global.breath > 0:
		$"../strain".texture = eye3
		$"../strain".visible = true
		$"../strain".scale = Vector2(2.2,2.2)
		$"../strain".self_modulate.a = 10
	elif Global.breath > 70:
		$"../strain".visible = false
		
	var directionX := Input.get_axis("Left", "Right")
	var directionY := Input.get_axis("Up", "Down")
	if Global.Player == "Conner":
		if not directionY and directionX:
			velocity.x = directionX * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	else:
		if directionX:
			velocity.x = directionX * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	
	if Global.Player == "Conner":
		if not directionX and directionY:
			velocity.y = directionY * speed
		else:
			velocity.y = move_toward(velocity.y, 0, speed)
	else:
		if directionY:
			velocity.y = directionY * speed
		else:
			velocity.y = move_toward(velocity.y, 0, speed)
			
	match Global.Player:
		"Bob":
			if directionY < 0:
				get_node("Sprite2D").texture = b3
			elif directionY > 0:
				get_node("Sprite2D").texture = b1
			elif directionX < 0:
				get_node("Sprite2D").texture = b2
				get_node("Sprite2D").flip_h = true
			elif directionX > 0:
				get_node("Sprite2D").texture = b2
				get_node("Sprite2D").flip_h = false
		"Conner":
			if directionY < 0:
				get_node("Sprite2D").texture = c3
			elif directionY > 0:
				get_node("Sprite2D").texture = c1
			elif directionX < 0:
				get_node("Sprite2D").texture = c2
				get_node("Sprite2D").flip_h = true
			elif directionX > 0:
				get_node("Sprite2D").texture = c2
				get_node("Sprite2D").flip_h = false
		"Paul":
			if directionY < 0:
				get_node("Sprite2D").texture = p3
			elif directionY > 0:
				get_node("Sprite2D").texture = p1
			elif directionX < 0:
				get_node("Sprite2D").texture = p2
				get_node("Sprite2D").flip_h = true
			elif directionX > 0:
				get_node("Sprite2D").texture = p2
				get_node("Sprite2D").flip_h = false
			
		
	if Global.mode == 3:
		if Input.is_action_just_pressed("Breath") and Global.breath < 75.0:
			if breathingup == false:
				get_node("Timer2").start(1.5)
				breathingup = true
				breathingdown = false
			Global.breath += (0.5+(breathup/2))/breathingdivide
		


	if Global.score < 0:
		if Global.Player == "Paul":
			Global.rebirth = true
			var index = 0
			for thing in Global.Unlocks:
				if thing == 1 and index != 2:
					currentunlocked.append(unlocks[index])
					index += 1
			print(currentunlocked, currentunlocked.size())
			Global.Player = str(currentunlocked[randi_range(0,currentunlocked.size()-1)])
			get_tree().change_scene_to_file("res://BaseLevel.tscn")
		elif not Global.Player == "Paul":
			Global.winlose = 2
			get_tree().change_scene_to_file("res://inbetween.tscn")
	elif Global.score >= 50:
		Global.winlose = 1
		get_tree().change_scene_to_file("res://inbetween.tscn")
	elif Global.breath <= 0:
		if Global.Player == "Paul":
			Global.rebirth = true
			var index = 0
			for thing in Global.Unlocks:
				if thing == 1 and index != 2:
					currentunlocked.append(unlocks[index])
					index += 1
			print(currentunlocked, currentunlocked.size())
			Global.Player = str(currentunlocked[randi_range(0,currentunlocked.size()-1)])
			get_tree().change_scene_to_file("res://BaseLevel.tscn")
		elif not Global.Player == "Paul":
			Global.winlose = 3
			get_tree().change_scene_to_file("res://inbetween.tscn")
	move_and_slide()
