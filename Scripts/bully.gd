extends CharacterBody2D

#@onready var nav: NavigationAgent2D = $NavigationAgent2D
@export var chase: CharacterBody2D

const s1 = preload("res://Bullies/Redson/Redson1.png")
const s2 = preload("res://Bullies/Redson/Redson2.png")
const bill = preload("res://Bullies/Classic/Bill1.png")

var chasepos = Vector2(0,0)
var chasing = false
var chased = 0
var rotate = 0
var nocollid = false

var speed = 250.0
var start = false

func _ready():
	match Global.Bully:
		"Bill":
			get_node("Sprite2D").texture = bill
	await get_tree().create_timer(2).timeout
	start = true
	

func _physics_process(delta: float) -> void:
	
	if start:
		if chasing == false:
			chased += 1
			chasepos = chase.global_position
			match Global.Bully:
				"Redson":
					get_node("Sprite2D").texture = s1
					chasing = true
					if Global.mode == 1:
						speed = randi_range(300,400)
					elif Global.mode == 2:
						speed = randi_range(400,520)
					elif Global.mode == 3:
						speed = randi_range(480,800)
				"Bill":
					get_node("Sprite2D").texture = bill
					chasing = true
					speed = 225 + position.distance_to(chasepos) + randi_range(-50,200)
					chasepos.x += randi_range(-200,200)
					chasepos.y += randi_range(-100,100)

			
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
					

		#else:
			#nav.target_position = chase.global_position
			#velocity = global_position.direction_to(nav.get_next_path_position()) * speed
		

		move_and_slide()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not nocollid:
		nocollid = true
		chasepos = position
		if Global.Bully == "Redson":
			Global.score -= 10
		elif Global.Bully == "Bill":
			Global.winlose = 4
			get_tree().change_scene_to_file("res://inbetween.tscn")
		chased += 20
		
		
