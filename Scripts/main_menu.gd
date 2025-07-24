extends Node2D

const SAVE = "user://save.save"
var unlocks = [preload("res://Players/Bob/Bob1.png"),preload("res://Players/Conner/Conner1.png"),preload("res://Players/Paul/Paul1.png"),preload("res://Players/Poppy/Poppy1.png"),preload("res://Players/Antony/Antony1.png"),"6",preload("res://Bullies/Redson/Redson1.png"),preload("res://Bullies/Classic/Bill1.png"),preload("res://Bullies/Clarence/Clarence1.png"),preload("res://Bullies/Jimmy/Jimmy1.png"),preload("res://Bullies/Snake/Snake1.png"),"12"]
var used = [0,0,0,0,0]
var pused = [0,0,0,0,0,0]
var index = 0

func _ready() -> void:
	Global.rebirth = false
	if FileAccess.file_exists(SAVE):
		var file = FileAccess.open(SAVE, FileAccess.READ)
		for thing in file.get_var():
			Global.Unlocks[index] = thing
			index += 1
		#Global.Unlocks = [1,0,0,0,0,0,1,0,0,0,0,0]
		file.close()
		
	else:
		var file = FileAccess.open(SAVE, FileAccess.WRITE)
		file.store_var([1,0,0,0,0,0,1,0,0,0,0,0])
		Global.Unlocks = [1,0,0,0,0,0,1,0,0,0,0,0]
		file.close()
	index = 0
	for thing in Global.Unlocks:
		if thing == 1:
			if index > 5:
				var unmatched = true
				if index == 10:
					unmatched = false
					$Bully6.visible = true
				while unmatched:
					match randi_range(1,5):
						1:
							if used[0] == 0:
								$Bully1.texture = unlocks[index]
								$Bully1.visible = true
								used[0] = 1
								unmatched = false
						2:
							if used[1] == 0:
								$Bully2.texture = unlocks[index]
								$Bully2.visible = true
								used[1] = 1
								unmatched = false
						3:
							if used[2] == 0:
								$Bully3.texture = unlocks[index]
								$Bully3.visible = true
								used[2] = 1
								unmatched = false
						4:
							if used[3] == 0:
								$Bully4.texture = unlocks[index]
								$Bully4.visible = true
								used[3] = 1
								unmatched = false
						5:
							if used[4] == 0:
								$Bully5.texture = unlocks[index]
								$Bully5.visible = true
								used[4] = 1
								unmatched = false
						#6:
							#if used[5] == 0:
								#$Bully6.texture = unlocks[index]
								#$Bully6.visible = true
								#used[5] = 1
								#unmatched = false
			else:
				var unmatched = true
				while unmatched:
					match randi_range(1,6):
						1:
							if pused[0] == 0:
								$Player1.texture = unlocks[index]
								$Player1.visible = true
								pused[0] = 1
								unmatched = false
						2:
							if pused[1] == 0:
								$Player2.texture = unlocks[index]
								$Player2.visible = true
								pused[1] = 1
								unmatched = false
						3:
							if pused[2] == 0:
								$Player3.texture = unlocks[index]
								$Player3.visible = true
								pused[2] = 1
								unmatched = false
						4:
							if pused[3] == 0:
								$Player4.texture = unlocks[index]
								$Player4.visible = true
								pused[3] = 1
								unmatched = false
						5:
							if pused[4] == 0:
								$Player5.texture = unlocks[index]
								$Player5.visible = true
								pused[4] = 1
								unmatched = false
						6:
							if pused[5] == 0:
								$Player6.texture = unlocks[index]
								$Player6.visible = true
								pused[5] = 1
								unmatched = false
		index += 1

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://BaseLevel.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://settings.tscn")

func _on_exit_pressed() -> void:
	var file = FileAccess.open(SAVE, FileAccess.WRITE)
	#file.store_var([1,0,0,0,0,0,1,0,0,0,0,0])
	file.store_var(Global.Unlocks)
	file.close()
	get_tree().quit()
