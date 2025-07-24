extends StaticBody2D

const inhaler = preload("res://coinjunk/inhaler.png")
const inhalebox = preload("res://coinjunk/Inhalebox.png")

var xrange = randi_range(-1000,1000)
var yrange = randi_range(-600,600)
var changeplace = true
var evilchangeplace = true
func _ready() -> void:
	#await get_tree().create_timer(1).timeout
	if self.name == "Inhaler":
		if Global.inhale or Global.Player == "Antony" or Global.Player == "Chromatic":
			$Sprite2D.texture = inhaler
			$Sprite2D.scale = Vector2(0.15,0.15)
			$CoinBox.scale = Vector2(0.132,0.12)
			$CoinBox.texture = inhalebox
			$Inhaler/CollisionShape2D.disabled = false
			$Area2D/CollisionShape2D.disabled = true
		else:
			self.queue_free()
	if self.name == "EvilCoin" or self.name == "EvilCoin2":
		if Global.evilcoin == true:
			$Sprite2D.self_modulate = Color("c9c9c9")
			$CoinBox.self_modulate = Color("c9c9c9")
		else:
			self.queue_free()
	self.position = Vector2(xrange,yrange)
	xrange = randi_range(-1000,1000)
	yrange = randi_range(-600,600)
	get_node("CoinBox").global_position = Vector2(xrange,yrange)

func _process(_delta: float) -> void:
	if self.name == "Inhaler":
		$Sprite2D.texture = inhaler
	if self.name == "EvilCoin" or self.name == "EvilCoin2":
		if evilchangeplace == true:
			evilchangeplace = false
			xrange = randi_range(-1000,1000)
			yrange = randi_range(-600,600)
			self.position = get_node("CoinBox").global_position
			get_node("CoinBox").global_position = Vector2(xrange,yrange)
			await get_tree().create_timer(3.5).timeout
			$Sprite2D.self_modulate = Color("ff0000")
			await get_tree().create_timer(0.5).timeout
			$Sprite2D.self_modulate = Color("c9c9c9")
			await get_tree().create_timer(0.5).timeout
			$Sprite2D.self_modulate = Color("ff0000")
			await get_tree().create_timer(0.5).timeout
			$Sprite2D.self_modulate = Color("c9c9c9")
			evilchangeplace = true
	if Global.mode == 3 and self.name != "Inhaler" and self.name != "EvilCoin" and self.name != "EvilCoin2":
		if changeplace == true:
			changeplace = false
			xrange = randi_range(-1000,1000)
			yrange = randi_range(-600,600)
			get_node("CoinBox").global_position = Vector2(xrange,yrange)
			await get_tree().create_timer(1).timeout
			changeplace = true
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if self.name == "Inhaler":
			if Global.inhale and (Global.Player == "Antony" or Global.Player == "Chromatic"):
				if Global.mode == 2 or Global.mode == 1:
					if Global.breath <= 130.0:
						Global.breath += 10.0
					else:
						Global.breath = 140.0
					body.inhale += 180
				else:
					if Global.breath <= 75.0:
						Global.breath += 40.0
					else:
						Global.breath = 115.0
					body.inhale += 180
			else:
				if Global.mode == 2 or Global.mode == 1:
					if Global.breath <= 110.0:
						Global.breath += 10.0
					else:
						Global.breath = 120.0
					body.inhale += 120
				else:
					if Global.breath <= 55.0:
						Global.breath += 40.0
					else:
						Global.breath = 95.0
					body.inhale += 120
			self.position = get_node("CoinBox").global_position
			xrange = randi_range(-1000,1000)
			yrange = randi_range(-600,600)
			get_node("CoinBox").global_position = Vector2(xrange,yrange)
			pass
		if self.name != "EvilCoin" and self.name != "Inhaler":
			Global.score += randi_range(1*Global.scoreup,(4-Global.mode)*Global.scoreup)
		elif self.name != "Inhaler":
			Global.score -= 5
		if self.name != "Inhaler":
			self.position = get_node("CoinBox").global_position
			xrange = randi_range(-1000,1000)
			yrange = randi_range(-600,600)
			get_node("CoinBox").global_position = Vector2(xrange,yrange)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemies") and not Global.Bully == "Snake" and self.name != "Inhaler":
		if self.name != "EvilCoin":
			Global.score -= 1
		else:
			Global.score += 1
		self.position = get_node("CoinBox").global_position
		xrange = randi_range(-1000,1000)
		yrange = randi_range(-600,600)
		get_node("CoinBox").global_position = Vector2(xrange,yrange)
