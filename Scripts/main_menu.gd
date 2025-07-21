extends Node2D

const SAVE = "user://save.save"
var Unlocks = []
var thisthing = [0,0,0,0,1,0,0]
var index = 0

func _ready() -> void:
	if FileAccess.file_exists(SAVE):
		var file = FileAccess.open(SAVE, FileAccess.READ)
		for thing in file.get_var():
			Global.Unlocks[index] = thing
			index += 1
		file.close()
		
	else:
		var file = FileAccess.open(SAVE, FileAccess.WRITE)
		file.store_var([1,0,0,0,0,0,1,0,0,0,0,0])
		file.close()
	

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://BaseLevel.tscn")
	
		


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_exit_pressed() -> void:
	var file = FileAccess.open(SAVE, FileAccess.WRITE)
	file.store_var([1,0,0,0,0,0,1,0,0,0,0,0])
	#file.store_var(Global.Unlocks)
	file.close()
	get_tree().quit()
	
	
