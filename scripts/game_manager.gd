extends Node

var lives = 3
var magicLevel = 1
var gems = 0
var coins = 0
var score = 0
var highscore = 0

func playSoundFX(stream):
	$SoundFX.stream = stream
	$SoundFX.play()

func _process(delta: float) -> void:
	$"GUI/CoinsValue".text = str(coins)
	$"GUI/ScoreValue".text = str(score)
	$"GUI/LivesValue".text = str(lives)

func completeLevel():
	$"GUI/YellowGemSprite".modulate = Color(255, 255, 255)
	$"GUI/BlueGemSprite".modulate = Color(255, 255, 255)
	$"GUI/RedGemSprite".modulate = Color(255, 255, 255)
	if score > highscore and lives != 0:
		highscore = score
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	lives = 3
	magicLevel = 1
	gems = 0
	coins = 0
	score = 0
	$GUI.hide()
