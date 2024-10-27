extends CharacterBody2D

const SPEED = 300
var movingRight = 1
var canSwitch = true
var isFalling = false


func _physics_process(delta: float) -> void:
	
	# slime moving left and right
	if (!$EdgeRayCast2D.is_colliding() or $WallRayCast2D.is_colliding()) and canSwitch:
		movingRight *= -1
		canSwitch = false
	else:
		canSwitch = true
	
	if movingRight < 0 and !isFalling:
		$EdgeRayCast2D.target_position = Vector2(-400, -150)
		velocity.x = SPEED * -1.0
		$WallRayCast2D.target_position = Vector2(-175, 0)
	elif !isFalling:
		velocity.x = SPEED * 1.0
		$EdgeRayCast2D.target_position = Vector2(400, -150)
		$WallRayCast2D.target_position = Vector2(175, 0)
	else:	# slime falls from ceiling
		velocity += get_gravity() * delta
	if $PlayerRayCast2D.is_colliding():
		isFalling = true
		velocity.x = 0
		GameManager.playSoundFX(load("res://assets/Sounds/Retro Blop 07.wav"))
		$PlayerRayCast2D.enabled = false

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.killPlayer()
