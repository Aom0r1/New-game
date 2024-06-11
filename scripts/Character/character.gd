extends CharacterBody2D

const SPEED = 300.0
var lastDir

func _ready():
	$AnimatedSprite2D.play("idle_down")

func _physics_process(delta):
	velocity = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
		).normalized() * SPEED
	
	if velocity:
		if velocity.x > 0:
			$AnimatedSprite2D.play("running_right")
			lastDir = "right"
		elif velocity.x < 0:
			$AnimatedSprite2D.play("running_left")
			lastDir = "left"
		elif velocity.y > 0:
			$AnimatedSprite2D.play("running_down")
			lastDir = "down"
		elif velocity.y < 0:
			$AnimatedSprite2D.play("running_up")
			lastDir = "up"
	else:
		if lastDir == "right":
				$AnimatedSprite2D.play("idle_right")
		elif lastDir == "left":
				$AnimatedSprite2D.play("idle_left")
		elif lastDir == "down":
				$AnimatedSprite2D.play("idle_down")
		elif lastDir == "up":
				$AnimatedSprite2D.play("idle_up")
	
	move_and_slide()
