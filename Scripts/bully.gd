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
const snake1 = preload("res://Bullies/Snake/Snake1.png")
const snake2 = preload("res://Bullies/Snake/Snake2.png")
const snake3 = preload("res://Bullies/Snake/Snake3.png")
var tail = 0

var chasepos = Vector2(0,0)
var chasing = false
var chased = 0
@warning_ignore("shadowed_variable_base_class")
var rotate = 0
var nocollid = false

var speeddown = 1
var speedup = Global.bullyspeedmulti

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
		"Snake":
			if self.name == "Bully" or self.name == "Child1" or self.name == "Child2":
				get_node("Sprite2D").texture = snake1
			if Global.snakes < 8:
				if Global.snakes == 7:
					Global.snakes += 1
					var clone := self.duplicate()
					clone.name = "Segment"
					clone.get_node("Sprite2D").texture = snake3
					clone.tail = 1
					self.add_child(clone)
					
				else:
					Global.snakes += 1
					var clone := self.duplicate()
					clone.name = "Segment"
					clone.get_node("Sprite2D").texture = snake2
					self.add_child(clone)
	if Global.mode == 2 or Global.mode == 1:
		if Global.addchild == true and self.name == "Child1":
			self.visible = true
		elif not self.name == "Bully" and not self.name == "Segment":
			self.visible = false
			self.queue_free()
	elif Global.mode == 3:
			if self.name == "Child1":
				self.visible = true
			if Global.addchild == true and self.name == "Child2":
				self.visible = true
			elif self.name == "Child2":
				self.visible = false
				self.queue_free()
	if self.name == "Child1":
		speeddown = 2
		if Global.Bully == "Snake":
			Global.snakes = -2
			if Global.snakes < 8:
				Global.snakes += 1
				var clone := self.duplicate()
				clone.speeddown = 2
				clone.get_node("Sprite2D").texture = snake2
				clone.scale = Vector2(1,1)
				clone.name = "Segment"
				self.add_child(clone)
		await get_tree().create_timer(2).timeout
	elif self.name == "Child2":
		speeddown = 3
		if Global.Bully == "Snake":
			Global.snakes = -5
			if Global.snakes < 8:
				Global.snakes += 1
				var clone := self.duplicate()
				clone.speeddown = 3
				clone.get_node("Sprite2D").texture = snake2
				clone.scale = Vector2(1,1)
				clone.name = "Segment"
				self.add_child(clone)
		await get_tree().create_timer(4).timeout
	await get_tree().create_timer(2).timeout
	start = true
	

func _physics_process(delta: float) -> void:
	if speedup != Global.bullyspeedmulti:
		speedup = Global.bullyspeedmulti
	if start:
		if Global.Bully != "Clarence" and Global.Bully != "Snake":
			if $JimmyTimer.is_stopped() and Global.Bully == "Jimmy":
				get_node("Sprite2D").texture = j2
				if not pause:
					match Global.mode:
						1:
							@warning_ignore("integer_division")
							speed = (400*speedup) / speeddown
						2:
							@warning_ignore("integer_division")
							speed = (800*speedup)/ speeddown
						3:
							@warning_ignore("integer_division")
							speed = (1000*speedup)/ speeddown
			elif Global.Bully == "Jimmy":
				get_node("Sprite2D").texture = j1
				if not pause:
					match Global.mode:
						1:
							@warning_ignore("integer_division")
							speed = (200*speedup)/ speeddown
						2:
							@warning_ignore("integer_division")
							speed = (400*speedup)/ speeddown
						3:
							@warning_ignore("integer_division")
							speed = (500*speedup)/ speeddown
			
			if chasing == false:
				chased += 1
				chasepos = chase.global_position
				match Global.Bully:
					"Redson":
						get_node("Sprite2D").texture = s1
						if Global.mode == 1:
							@warning_ignore("integer_division")
							speed = (randi_range(300,400)*speedup)/ speeddown
						elif Global.mode == 2:
							@warning_ignore("integer_division")
							speed = (randi_range(400,520)*speedup)/ speeddown
						elif Global.mode == 3:
							@warning_ignore("integer_division")
							speed = (randi_range(480,600)*speedup)/ speeddown
					"Bill":
						get_node("Sprite2D").texture = bill
						match Global.mode:
							1:
								speed = (0 + (position.distance_to(chasepos)/ speeddown) + randi_range(-150,50))*speedup
							2:
								speed = (115 + (position.distance_to(chasepos)/ speeddown) + randi_range(-100,150))*speedup
							3:
								speed = (225 + (position.distance_to(chasepos)/ speeddown) + randi_range(-50,200))*speedup
						chasepos.x += randi_range(-200*speeddown,200*speeddown)
						chasepos.y += randi_range(-100*speeddown,100*speeddown)
			chasing = true
			position += position.direction_to(chasepos) * speed * delta
			if position.distance_to(chasepos) < 30:
				chasing = false
				match Global.Bully:
					"Redson":
						match Global.mode:
							1:
								if chased >= 5*speeddown:
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
								if chased >= 7*speeddown:
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
								if chased >= 10*speeddown:
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
						if chased >= 8*speeddown:
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
			if Global.Bully == "Clarence":
				if chased == 0:
					get_node("Sprite2D").texture = c1
					match Global.mode:
						1:
							@warning_ignore("integer_division")
							speed = (300*speedup)/ speeddown
						2:
							@warning_ignore("integer_division")
							speed = (380*speedup)/ speeddown
						3:
							@warning_ignore("integer_division")
							speed = (450*speedup)/ speeddown
				else:
					match Global.mode:
						1:
							@warning_ignore("integer_division")
							speed = (200*speedup)/ speeddown
						2:
							@warning_ignore("integer_division")
							speed = (300*speedup)/ speeddown
						3:
							@warning_ignore("integer_division")
							speed = (400*speedup)/ speeddown
					get_node("Sprite2D").texture = c2
					rotate += 1
					if rotate > 400*speeddown:
						chased = 0
						rotate = 0
				if chasing == false:
					nav.target_position = chase.global_position
					velocity = global_position.direction_to(nav.get_next_path_position()) * speed
			else:
				if chasing == false:
					if self.name == "Bully" or self.name == "Child1" or self.name == "Child2":
						match Global.mode:
							1:
								speed = (200*speedup)/ speeddown
							2:
								speed = (350*speedup)/ speeddown
							3:
								speed = (450*speedup)/ speeddown
						if rotate > 30:
							nav.target_position = chase.global_position + Vector2(randi_range(-300,300),randi_range(-300,300))
							rotate = 0
						rotate += 1
						velocity = global_position.direction_to(nav.get_next_path_position()) * speed
						$Node2D.look_at(nav.get_next_path_position())
						$Node2D.rotation_degrees -= 180
					elif self.name == "Segment":
						match Global.mode:
							1:
								speed = (200*speedup)/ speeddown
							2:
								speed = (350*speedup)/ speeddown
							3:
								speed = (450*speedup)/ speeddown
						if rotate > 10:
							$Node2D.look_at(get_parent().global_position)
							$Node2D.rotation_degrees -= 180
							rotate = 0
						rotate += 1
						global_position = lerp(global_position, get_parent().get_node("Node2D/Marker2D").global_position, 0.1)
					if self.global_position.distance_to(nav.target_position) < 30:
						velocity = Vector2(0,0)
						rotate = 0
						if self.name == "Bully" or self.name == "Child1" or self.name == "Child2":
							nav.target_position = chase.global_position + Vector2(randi_range(-300,300),randi_range(-300,300))
					if tail == 1:
						#print("tail")
						self.look_at(get_parent().global_position)
						self.rotation_degrees -= 90
					
					
		move_and_slide()
	else:
		if self.name == "Segment":
			global_position = get_parent().get_node("Node2D/Marker2D").global_position
	

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
		elif Global.Bully == "Snake":
			body.breathingadd += 2
		chased += 20


func _on_jimmy_button_pressed() -> void:
	if Global.Bully == "Jimmy":
		Global.breath -= 5
		$JimmyTimer.start(2)
