extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/HighscoreValue.text = str(GameManager.highscore)
	get_node("/root/GameManager/BackgroundMusic").stream = load("res://assets/Sounds/Ambient 8.wav")
	get_node("/root/GameManager/BackgroundMusic").playing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
