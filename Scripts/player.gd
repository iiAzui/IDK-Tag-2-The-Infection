extends CharacterBody2D

var eye1 = preload("res://eyestrain/eye1.png")
var eye2 = preload("res://eyestrain/eye2.png")
var eye3 = preload("res://eyestrain/eye3.png")

var b1 = preload("res://Players/Bob/Bob1.png")
var b2 = preload("res://Players/Bob/Bob2.png")
var b3 = preload("res://Players/Bob/Bob3.png")

var speed = 400.0

var breathingup = false
var breathed = false
var breathingdown = false
func _ready() -> void:
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
			
	while Global.mode == 2:
		if not Input.is_action_pressed("Breath") or breathed:
			if breathingdown == false:
				get_node("Timer").start(2)
				breathingdown = true
			await get_node("Timer").timeout
			Global.breath -= randi_range(1,5)
			breathingdown = false
		else:
			if breathingdown == false:
				get_node("Timer").start(2)
				breathingdown = true
			await get_node("Timer").timeout
			while Input.is_action_pressed("Breath") and not breathed:
				Global.breath += 1
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
					Global.breath -= randi_range(5,10)
					breathingdown = false
		else: 
			await get_node("Timer2").timeout
			breathingup = false
			
			


func _physics_process(delta: float) -> void:
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
	if directionX:
		velocity.x = directionX * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
		
	
	var directionY := Input.get_axis("Up", "Down")
	if directionY:
		velocity.y = directionY * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	
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
		
	if Global.mode == 3:
		if Input.is_action_just_pressed("Breath") and Global.breath < 75.0:
			if breathingup == false:
				get_node("Timer2").start(1.5)
				breathingup = true
				breathingdown = false
			Global.breath += 0.5
		


	if Global.score < 0:
		Global.winlose = 2
		get_tree().change_scene_to_file("res://inbetween.tscn")
	elif Global.score >= 50:
		Global.winlose = 1
		get_tree().change_scene_to_file("res://inbetween.tscn")
	elif Global.breath < 0:
		Global.winlose = 3
		get_tree().change_scene_to_file("res://inbetween.tscn")


	move_and_slide()
