extends Node2D

signal goahead

var Conner = preload("res://Players/Conner/Conner1.png")
var Paul = preload("res://Players/Paul/Paul1.png")
var Poppy = preload("res://Players/Poppy/Poppy1.png")
var Antony = preload("res://Players/Antony/Antony1.png")
var Chromatic = preload("res://Players/Chromatic/Chromatic1.png")

const Bill = preload("res://Bullies/Classic/Bill1.png")
const Clarence = preload("res://Bullies/Clarence/Clarence1.png")
const Jimmy = preload("res://Bullies/Jimmy/Jimmy1.png")
const Snake = preload("res://Bullies/Snake/Snake4.png")


const SAVE = "user://save.save"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.snakes = 0
	if Global.Player == "Secret":
		Global.bullyspeedmulti -= 1
	match Global.winlose:
		1:
			get_node("You Win").visible = true
			get_node("You Lost").visible = false
			get_node("Suffocate").visible = false
			get_node("Tagged").visible = false
			if Global.bullyspeedmulti > 0:
				if Global.mode == 3:
					if Global.rebirth == true:
						if Global.chrome:
							Global.Unlocks[5] = 2
						else:
							Global.Unlocks[2] = 2
					else:
						Global.Unlocks[Global.unlocksname.bsearch(Global.Player)] = 2
				if Global.Unlocks[0] == 2 and Global.Unlocks[1] == 2 and Global.Unlocks[2] == 2 and Global.Unlocks[3] == 2 and Global.Unlocks[4] == 2:
					Global.Unlocks[5] = 1
					unlocked("Chromatic",Chromatic)
					await goahead
				if Global.mode == 3:
					if Global.Unlocks[7] == 0:
						Global.Unlocks[7] = 1
						unlocked("Bill",Bill)
						await goahead
					if Global.Unlocks[10] == 0 and Global.addchild == true:
						Global.Unlocks[10] = 1
						unlocked("Snake",Snake)
						await goahead
				if Global.mode == 2 or Global.mode == 3:
					Global.nrmwins += 1
					if Global.nrmwins == 3 and Global.Unlocks[8] == 0:
						Global.Unlocks[8] = 1
						unlocked("Clarence",Clarence)
						await goahead
				if Global.breath < 20 and Global.Unlocks[3] == 0:
					Global.Unlocks[3] = 1
					unlocked("Poppy",Poppy)
					await goahead
				if Global.Unlocks[4] == 0 and Global.Player == "Conner" and Global.Bully == "Clarence":
					Global.Unlocks[4] = 1
					unlocked("Antony",Antony)
					await goahead

		2:
			get_node("You Win").visible = false
			get_node("You Lost").visible = true
			get_node("Suffocate").visible = false
			get_node("Tagged").visible = false
			Global.nrmwins = 0
			if Global.bullyspeedmulti > 0:
				if Global.score >= 45 and Global.Unlocks[9] == 0:
					Global.Unlocks[9] = 1
					unlocked("Jimmy",Jimmy)
					await goahead
			if Global.bullyspeedmulti < 0 and Global.Unlocks[1] == 0:
				Global.Unlocks[1] = 1
				unlocked("Conner",Conner)
				await goahead


		3:
			get_node("You Win").visible = false
			get_node("You Lost").visible = false
			get_node("Suffocate").visible = true
			get_node("Tagged").visible = false
			Global.nrmwins = 0
			if Global.bullyspeedmulti > 0:
				if Global.mode == 1 and Global.Unlocks[2] == 0:
					Global.Unlocks[2] = 1
					unlocked("Paul",Paul)
					await goahead
				if Global.score >= 45 and Global.Unlocks[9] == 0:
					Global.Unlocks[9] = 1
					unlocked("Jimmy",Jimmy)
					await goahead
			if Global.bullyspeedmulti < 0 and Global.Unlocks[1] == 0:
				Global.Unlocks[1] = 1
				unlocked("Conner",Conner)
				await goahead
		4:
			get_node("You Win").visible = false
			get_node("You Lost").visible = false
			get_node("Suffocate").visible = false
			get_node("Tagged").visible = true
			Global.nrmwins = 0
			if Global.bullyspeedmulti > 0:
				if Global.score >= 45 and Global.Unlocks[9] == 0:
					Global.Unlocks[9] = 1
					unlocked("Jimmy",Jimmy)
					await goahead
			if Global.bullyspeedmulti < 0 and Global.Unlocks[1] == 0:
				Global.Unlocks[1] = 1
				unlocked("Conner",Conner)
				await goahead

	var file = FileAccess.open(SAVE, FileAccess.WRITE)
	file.store_var(Global.Unlocks)
	file.close()

func _on_play_again_pressed() -> void:
	if Global.rebirth == true:
		if Global.chrome:
			Global.Player = "Chromatic"
		else:
			Global.Player = "Paul"
		Global.rebirth = false
	get_tree().change_scene_to_file("res://BaseLevel.tscn")

func _on_menu_pressed() -> void:
	if Global.rebirth == true:
		if Global.chrome:
			Global.Player = "Chromatic"
		else:
			Global.Player = "Paul"
		Global.rebirth = false
	Global.rebirth = false
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_quit_pressed() -> void:
	Global.rebirth = false
	get_tree().quit()
	
func unlocked(thing,spritepath):
	if thing == "Snake":
		$"Unlocked!/Bob1".scale = Vector2(1,1)
		$"Unlocked!/Bob1".position.x = 720
	else:
		$"Unlocked!/Bob1".scale = Vector2(0.25,0.25)
		$"Unlocked!/Bob1".position.x = 598
	if thing == "Chromatic":
		$"Unlocked!/Label".scale = Vector2(0.89,0.89)
	else:
		$"Unlocked!/Label".scale = Vector2(1,1)
	$"Unlocked!/VideoStreamPlayer".play()
	$"Unlocked!".visible = true
	$"Unlocked!/Label".text = "Unlocked: "+str(thing)
	$"Unlocked!/Bob1".texture = spritepath
	await $"Unlocked!/Ok".pressed
	$"Unlocked!".visible = false
	$"Unlocked!/VideoStreamPlayer".stop()
	emit_signal("goahead")
