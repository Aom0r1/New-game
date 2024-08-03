extends CharacterBody2D

@export var sword = PackedScene
@export var hp = 20
@export var speed = 300.0
var lastDir

func _ready():
	sword = preload("res://scenes/Weapons/sword.tscn")

func _physics_process(delta):
	velocity = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
		).normalized() * speed
	
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
	
	if Input.is_action_just_pressed("ui_page_down"):
		hp -= 1
	elif Input.is_action_just_pressed("ui_page_up"):
		hp += 1
		
	move_and_slide()
	
func _on_area_2d_body_entered(body):
	if body.name == "mob":
		var s = sword.instantiate()
		get_parent().add_child(s)
		var swordPos = global_position
		var angle_rad = atan2(body.position.y - global_position.y, body.position.x - global_position.x)
		s.rotation = angle_rad
		swordPos.y += 38
		s.position = swordPos



