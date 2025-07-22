extends CharacterBody2D

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@export var chase: CharacterBody2D
var unlocks = Global.unlocksname
var currentunlocked = []
const s1 = preload("res://Bullies/Redson/Redson1.png")
const s2 = preload("res://Bullies/Redson/Redson2.png")
const bill = preload("res://Bullies/Classic/Bill1.png")
const c1 = preload("res://Bullies/Clarence/Clarence1.png")
const c2 = preload("res://Bullies/Clarence/Clarence2.png")
const j1 = preload("res://Bullies/Jimmy/Jimmy1.png")
const j2 = preload("res://Bullies/Jimmy/Jimmy2.png")

var chasepos = Vector2(0,0)
var chasing = false
var chased = 0
var rotate = 0
var nocollid = false

var pause = false

var speed = 250.0
var start = false

func _ready():
	match Global.Bully:
		"Bill":
			get_node("Sprite2D").texture = bill
		"Clarence":
			get_node("Sprite2D").texture = c1
		"Jimmy":
			get_node("Sprite2D").texture = j1
			$JimmyTimer.start(4)
	await get_tree().create_timer(2).timeout
	start = true
	

func _physics_process(delta: float) -> void:
	
	if start:
		if Global.Bully != "Clarence":
			if $JimmyTimer.is_stopped() and Global.Bully == "Jimmy":
				get_node("Sprite2D").texture = j2
				if not pause:
					match Global.mode:
						1:
							speed = 400
						2:
							speed = 800
						3:
							speed = 1000
			elif Global.Bully == "Jimmy":
				get_node("Sprite2D").texture = j1
				if not pause:
					match Global.mode:
						1:
							speed = 200
						2:
							speed = 400
						3:
							speed = 500
			
			if chasing == false:
				chased += 1
				chasepos = chase.global_position
				match Global.Bully:
					"Redson":
						get_node("Sprite2D").texture = s1
						if Global.mode == 1:
							speed = randi_range(300,400)
						elif Global.mode == 2:
							speed = randi_range(400,520)
						elif Global.mode == 3:
							speed = randi_range(480,600)
					"Bill":
						get_node("Sprite2D").texture = bill
						match Global.mode:
							1:
								speed = 0 + position.distance_to(chasepos) + randi_range(-150,50)
							2:
								speed = 115 + position.distance_to(chasepos) + randi_range(-100,150)
							3:
								speed = 225 + position.distance_to(chasepos) + randi_range(-50,200)
						chasepos.x += randi_range(-200,200)
						chasepos.y += randi_range(-100,100)
			chasing = true
			position += position.direction_to(chasepos) * speed * delta
			if position.distance_to(chasepos) < 30:
				chasing = false
				match Global.Bully:
					"Redson":
						match Global.mode:
							1:
								if chased >= 5:
									chasing = true
									get_node("Sprite2D").texture = s2
									if rotate < 240:
										get_node("Sprite2D").rotate(delta * deg_to_rad(720))
										rotate += 1
									else:
										chasing = false
										chased = 0
										rotate = 0
										nocollid = false

							2:
								if chased >= 7:
									chasing = true
									get_node("Sprite2D").texture = s2
									if rotate < 120:
										get_node("Sprite2D").rotate(delta * deg_to_rad(720))
										rotate += 1
									else:
										chasing = false
										chased = 0
										rotate = 0
										nocollid = false

							3:
								if chased >= 10:
									chasing = true
									get_node("Sprite2D").texture = s2
									if rotate < 120:
										get_node("Sprite2D").rotate(delta * deg_to_rad(720))
										rotate += 1
									else:
										chasing = false
										chased = 0
										rotate = 0
										nocollid = false
					"Bill":
						if chased >= 8:
							chasing = true
							speed = 0
							if rotate < 60:
								rotate += 1
							else:
								chasing = false
								chased = 0
								rotate = 0
								nocollid = false
					"Jimmy":
						if chased > 0:
							pause = true
							chasing = true
							speed = 0
							if rotate < 10:
								rotate += 1
							else:
								chasing = false
								pause = false
								chased = 0
								rotate = 0
								nocollid = false
		else:
			if chased == 0:
				get_node("Sprite2D").texture = c1
				match Global.mode:
					1:
						speed = 300
					2:
						speed = 380
					3:
						speed = 450
			else:
				match Global.mode:
					1:
						speed = 200
					2:
						speed = 300
					3:
						speed = 400
				get_node("Sprite2D").texture = c2
				rotate += 1
				if rotate > 400:
					chased = 0
					rotate = 0
			if chasing == false:
				nav.target_position = chase.global_position
				velocity = global_position.direction_to(nav.get_next_path_position()) * speed
		move_and_slide()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not nocollid:
		nocollid = true
		chasepos = position
		if Global.Bully == "Redson":
			Global.score -= 10
		elif Global.Bully == "Bill" or Global.Bully == "Jimmy":
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
			elif Global.Player != "Paul":
				Global.winlose = 4
				get_tree().change_scene_to_file("res://inbetween.tscn")
		elif Global.Bully == "Clarence":
			chasing = true
			velocity = Vector2(0,0)
			if chased == 0:
				await get_tree().create_timer(2).timeout
				chasing = false
				nocollid = false
			if chased > 0:
				match Global.mode:
					1: 
						Global.breath -= 20
						chased = -20
					2:
						Global.breath -= 40
						chased = -20
					3:
						Global.breath -= 55
						if chased > 21:
							chased = -20
				await get_tree().create_timer(2).timeout
				chasing = false
				nocollid = false
				rotate = -200
		chased += 20


func _on_jimmy_button_pressed() -> void:
	if Global.Bully == "Jimmy":
		Global.breath -= 5
		$JimmyTimer.start(2)
