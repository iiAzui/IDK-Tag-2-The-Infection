extends Node2D

var index = 0
var unlocks = Global.unlocksname

func _ready() -> void:
	%PB.position = Global.PBPos
	%BB.position = Global.BBPos
	match Global.mode:
		1:
			get_node("Easy/ez").self_modulate = Color(255,255,255)
			get_node("Normal/nrm").self_modulate = Color(0,144,255)
			get_node("Hard/hard").self_modulate = Color(255,0,0)
		2:
			get_node("Easy/ez").self_modulate = Color(255,255,0)
			get_node("Normal/nrm").self_modulate = Color(255,255,255)
			get_node("Hard/hard").self_modulate = Color(255,0,0)
		3:
			get_node("Easy/ez").self_modulate = Color(255,255,0)
			get_node("Normal/nrm").self_modulate = Color(0,144,255)
			get_node("Hard/hard").self_modulate = Color(255,255,255)
		
			
	for thing in Global.Unlocks:
		if thing == 1:
			get_node(unlocks[index]).self_modulate = Color("ffffff")
			get_node(str(unlocks[index])+ "/"+str(unlocks[index])+"Bttn").disabled = false
			get_node(str(unlocks[index])+ "/UnlockText").visible = false
			get_node(str(unlocks[index])+ "/Label").visible = true
		else:
			get_node(unlocks[index]).self_modulate = Color("454545")
			get_node(str(unlocks[index])+ "/UnlockText").visible = true
			get_node(str(unlocks[index])+ "/"+str(unlocks[index])+"Bttn").disabled = true
			get_node(str(unlocks[index])+ "/Label").visible = false
		index += 1
					
func _on_easy_pressed() -> void:
	Global.mode = 1
	get_node("Easy/ez").self_modulate = Color(255,255,255)
	get_node("Normal/nrm").self_modulate = Color(0,144,255)
	get_node("Hard/hard").self_modulate = Color(255,0,0)


func _on_normal_pressed() -> void:
	Global.mode = 2
	get_node("Easy/ez").self_modulate = Color(255,255,0)
	get_node("Normal/nrm").self_modulate = Color(255,255,255)
	get_node("Hard/hard").self_modulate = Color(255,0,0)
	


func _on_hard_pressed() -> void:
	Global.mode = 3
	get_node("Easy/ez").self_modulate = Color(255,255,0)
	get_node("Normal/nrm").self_modulate = Color(0,144,255)
	get_node("Hard/hard").self_modulate = Color(255,255,255)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	

func _on_bob_bttn_pressed() -> void:
	Global.Player = "Bob"
	%PB.position = get_node("Bob").position
	Global.PBPos = %PB.position


func _on_2_bttn_pressed() -> void:
	Global.Player = "Conner"
	%PB.position = get_node("Conner").position
	Global.PBPos = %PB.position


func _on_3_bttn_pressed() -> void:
	Global.Player = "Paul"
	%PB.position = get_node("Paul").position
	Global.PBPos = %PB.position


func _on_4_bttn_pressed() -> void:
	Global.Player = "Poppy"
	%PB.position = get_node("Poppy").position
	Global.PBPos = %PB.position


func _on_5_bttn_pressed() -> void:
	pass # Replace with function body.


func _on_6_bttn_pressed() -> void:
	pass # Replace with function body.

func _on_redson_bttn_pressed() -> void:
	Global.Bully = "Redson"
	%BB.position = get_node("Redson").position
	Global.BBPos = %BB.position
	

func _on_bill_bttn_pressed() -> void:
	Global.Bully = "Bill"
	%BB.position = get_node("Bill").position
	Global.BBPos = %BB.position

func _on_9_bttn_pressed() -> void:
	Global.Bully = "Clarence"
	%BB.position = get_node("Clarence").position
	Global.BBPos = %BB.position


func _on_10_bttn_pressed() -> void:
	Global.Bully = "Jimmy"
	%BB.position = get_node("Jimmy").position
	Global.BBPos = %BB.position


func _on_11_bttn_pressed() -> void:
	pass # Replace with function body.


func _on_12_bttn_pressed() -> void:
	pass # Replace with function body.


func _on_more_pressed() -> void:
	get_tree().change_scene_to_file("res://more.tscn")
