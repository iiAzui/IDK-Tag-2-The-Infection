extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
