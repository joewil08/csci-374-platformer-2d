extends Area2D

var speed = 1500
var velocity
var playerObject
var direction = 1
@onready var magic = $Magic1/CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerObject = get_node("../Player").get_node("AnimatedSprite2D")
	$Timer.connect("timeout", _on_timer_timeout)
	if GameManager.magicLevel == 2:
		magic = $Magic2/CPUParticles2D
		$Magic1.queue_free()
		$Magic3.queue_free()
		$RedGlow.queue_free()
	elif GameManager.magicLevel == 3:
		magic = $Magic3/CPUParticles2D
		$Magic1.queue_free()
		$Magic2.queue_free()
		$PurpleGlow.queue_free()
		$PurpleGlow.queue_free()
	else:
		$Magic2.queue_free()
		$Magic3.queue_free()
		$PurpleGlow.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction == 1:
		velocity = Vector2(-1, 0).rotated(rotation_degrees) * speed * delta
		magic.gravity.x = 3000
	else:
		velocity = Vector2(1, 0).rotated(rotation_degrees) * speed * delta
		magic.gravity.x = -3000
	position += velocity

func _on_timer_timeout():
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		GameManager.playSoundFX(load("res://assets/Sounds/Retro Roar 02.wav"))
		GameManager.score += 250
		area.get_parent().queue_free()
		queue_free()
	elif area.is_in_group("BigEnemyII") and GameManager.magicLevel >= 2:
		GameManager.playSoundFX(load("res://assets/Sounds/Retro Roar 02.wav"))
		GameManager.score += 500
		area.get_parent().queue_free()
		queue_free()
	elif area.is_in_group("BigEnemyIII") and GameManager.magicLevel == 3:
		GameManager.playSoundFX(load("res://assets/Sounds/Retro Roar 02.wav"))
		GameManager.score += 750
		area.get_parent().queue_free()
		queue_free()
	elif (area.is_in_group("BigEnemyII") and GameManager.magicLevel < 2) or (area.is_in_group("BigEnemyIII") and GameManager.magicLevel < 3):
		# add SFX here
		GameManager.score -= 10
		queue_free()
