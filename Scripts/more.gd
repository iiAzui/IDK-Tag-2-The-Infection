extends Node2D

const s1 = preload("res://Players/Secret/Secret1.png")
const s2 = preload("res://Players/Secret/Secret.png")

func _ready() -> void:
	if Global.Player == "Secret":
		%PB.position = get_node("Secret").position
		$Secret/Label.visible = true
		$Secret.texture = s1
	else:
		%PB.position = Vector2(-94,141)
		$Secret/Label.visible = false
		$Secret.texture = s2

func _physics_process(_delta: float) -> void:
	if Global.addchild == true:
		$AddChild/Label.self_modulate = Color("ffffff")
	else:
		$AddChild/Label.self_modulate = Color("ff0000")
	if Global.evilcoin == true:
		$EvilCoins/Label.self_modulate = Color("ffffff")
	else:
		$EvilCoins/Label.self_modulate = Color("ff0000")
	if Global.inhale == true:
		$Inhaler/Label.self_modulate = Color("ffffff")
	else:
		$Inhaler/Label.self_modulate = Color("ff0000")
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


func _on_inhaler_pressed() -> void:
	if Global.inhale == false:
		Global.inhale = true
	else:
		Global.inhale = false


func _on_secret_bttn_pressed() -> void:
	Global.Player = "Secret"
	$Secret/Label.visible = true
	%PB.position = get_node("Secret").position
	Global.PBPos = %PB.position
	$Secret.texture = s1
