extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameManager.playSoundFX(load("res://assets/Sounds/Retro Event 19.wav"))
		GameManager.gems += 1
		if GameManager.gems == 3:
			%GreenGem/Area2D.monitoring = true
			%GreenGem.modulate = Color(1, 1, 1, 1)
			%GreenGem/PointLight2D.enabled = true
		GameManager.score += 1500
		get_node("/root/GameManager/GUI/YellowGemSprite").modulate = Color(1, 1, 1, 1)
		queue_free()
