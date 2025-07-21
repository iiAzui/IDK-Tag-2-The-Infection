extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.winlose == 1:
		get_node("You Win").visible = true
		get_node("You Lost").visible = false
		get_node("Suffocate").visible = false
	elif Global.winlose == 2:
		get_node("You Win").visible = false
		get_node("You Lost").visible = true
		get_node("Suffocate").visible = false
	elif Global.winlose == 3:
		get_node("You Win").visible = false
		get_node("You Lost").visible = false
		get_node("Suffocate").visible = true



func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://BaseLevel.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
