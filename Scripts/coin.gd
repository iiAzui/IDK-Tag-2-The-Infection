extends StaticBody2D

var xrange = randi_range(-1000,1000)
var yrange = randi_range(-600,600)
var changeplace = true
func _ready() -> void:
	self.position = Vector2(xrange,yrange)
	xrange = randi_range(-1000,1000)
	yrange = randi_range(-600,600)
	get_node("CoinBox").global_position = Vector2(xrange,yrange)

func _process(delta: float) -> void:
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
		Global.score += randi_range(1,4-Global.mode)
		self.position = get_node("CoinBox").global_position
		xrange = randi_range(-1000,1000)
		yrange = randi_range(-600,600)
		get_node("CoinBox").global_position = Vector2(xrange,yrange)
	
		
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemies"):
		Global.score -= 1
		self.position = get_node("CoinBox").global_position
		xrange = randi_range(-1000,1000)
		yrange = randi_range(-600,600)
		get_node("CoinBox").global_position = Vector2(xrange,yrange)
