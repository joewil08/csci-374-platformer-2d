extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"/root/GameManager/GUI".show()
	get_node("/root/GameManager/BackgroundMusic").stream = load("res://assets/Sounds/Light Ambience 2.wav")
	get_node("/root/GameManager/BackgroundMusic").playing = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
