extends Node2D

func _physics_process(_delta: float) -> void:
	if Global.addchild == true:
		$AddChild/Label.self_modulate = Color("ffffff")
	else:
		$AddChild/Label.self_modulate = Color("ff0000")
	if Global.evilcoin == true:
		$EvilCoins/Label.self_modulate = Color("ffffff")
	else:
		$EvilCoins/Label.self_modulate = Color("ff0000")
	$BullySpeedMulti.text = "BS Multiplier: " + str(Global.bullyspeedmulti)



func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_add_child_pressed() -> void:
	if Global.addchild == false:
		Global.addchild = true
	else:
		Global.addchild = false


func _on_bully_speed_up_pressed() -> void:
	Global.bullyspeedmulti += 1


func _on_bully_speed_down_pressed() -> void:
	Global.bullyspeedmulti -= 1


func _on_evil_coins_pressed() -> void:
	if Global.evilcoin == false:
		Global.evilcoin = true
	else:
		Global.evilcoin = false
