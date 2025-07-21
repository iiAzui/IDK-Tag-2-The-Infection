extends Node2D

const SAVE = "user://save.save"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match Global.winlose:
		1:
			get_node("You Win").visible = true
			get_node("You Lost").visible = false
			get_node("Suffocate").visible = false
			get_node("Tagged").visible = false
			if Global.mode == 3:
				Global.Unlocks[7] = 1

		2:
			get_node("You Win").visible = false
			get_node("You Lost").visible = true
			get_node("Suffocate").visible = false
			get_node("Tagged").visible = false

		3:
			get_node("You Win").visible = false
			get_node("You Lost").visible = false
			get_node("Suffocate").visible = true
			get_node("Tagged").visible = false
		4:
			get_node("You Win").visible = false
			get_node("You Lost").visible = false
			get_node("Suffocate").visible = false
			get_node("Tagged").visible = true
	var file = FileAccess.open(SAVE, FileAccess.WRITE)
	file.store_var(Global.Unlocks)
	file.close()



func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://BaseLevel.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
