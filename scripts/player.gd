extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -1900.0
var can_double_jump = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		can_double_jump = true
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		GameManager.playSoundFX(load("res://assets/Sounds/Retro Jump StereoUP Simple 01.wav"))
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")
	elif Input.is_action_just_pressed("jump") and can_double_jump:
		GameManager.playSoundFX(load("res://assets/Sounds/Retro Jump StereoUP Simple 05.wav"))
		velocity.y = JUMP_VELOCITY / 1.2
		can_double_jump = false
		$AnimatedSprite2D.play("jump")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var run_multiplier = 1
	
	if Input.is_action_pressed("run"):
		run_multiplier = 2
	else:
		run_multiplier = 1
	
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED * run_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * run_multiplier)
		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		
	if velocity.x != 0 and is_on_floor():
		$AnimatedSprite2D.play("walk")
	elif is_on_floor():
		$AnimatedSprite2D.play("idle")

	move_and_slide()
	
	if Input.is_action_just_pressed("magic"):
		GameManager.playSoundFX(load("res://assets/Sounds/Retro Magic 11.wav"))
		var magicNode = load("res://scenes/magic_area.tscn")
		var newMagic = magicNode.instantiate()
		if $AnimatedSprite2D.flip_h == false:
			newMagic.direction = -1
		else:
			newMagic.direction = 1
		newMagic.set_position($MagicSpawnPoint.global_transform.origin)
		get_parent().add_child(newMagic)
	
func killPlayer():
	GameManager.lives -= 1
	GameManager.score -= 3250
	if GameManager.lives == 0:
		GameManager.playSoundFX(load("res://assets/Sounds/Retro Negative Melody 01 - aCustom1.wav"))
		GameManager.completeLevel()
		return
	GameManager.playSoundFX(load("res://assets/Sounds/Retro Descending Long 04.wav"))
	position = %RespawnPoint.position
	$AnimatedSprite2D.flip_h = false

func _on_death_area_body_entered(body: Node2D) -> void:
	killPlayer()
