extends StaticBody2D

var xrange = randi_range(-1000,1000)
var yrange = randi_range(-600,600)
var changeplace = true
func _ready() -> void:
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
	if self.name == "EvilCoin" or self.name == "EvilCoin2" and Global.mode != 3:
		if changeplace == true:
			changeplace = false
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
			changeplace = true
	if Global.mode == 3:
		if changeplace == true:
			changeplace = false
			xrange = randi_range(-1000,1000)
			yrange = randi_range(-600,600)
			get_node("CoinBox").global_position = Vector2(xrange,yrange)
			await get_tree().create_timer(1).timeout
			changeplace = true
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if self.name != "EvilCoin":
			Global.score += randi_range(1*Global.scoreup,(4-Global.mode)*Global.scoreup)
		else:
			Global.score -= 5
		self.position = get_node("CoinBox").global_position
		xrange = randi_range(-1000,1000)
		yrange = randi_range(-600,600)
		get_node("CoinBox").global_position = Vector2(xrange,yrange)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemies"):
		if self.name != "EvilCoin":
			Global.score -= 1
		else:
			Global.score += 1
		self.position = get_node("CoinBox").global_position
		xrange = randi_range(-1000,1000)
		yrange = randi_range(-600,600)
		get_node("CoinBox").global_position = Vector2(xrange,yrange)
