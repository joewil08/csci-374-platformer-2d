extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.playSoundFX(load("res://assets/Sounds/Retro Event Echo 12.wav"))
	GameManager.score += 3000
	GameManager.completeLevel()
	queue_free()
