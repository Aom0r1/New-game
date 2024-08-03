extends CharacterBody2D

@export var sword = PackedScene
@export var hp = 20
@export var speed = 300.0
var lastDir
var mobBody
var mobInArea =  false
var initialChildCount = null


func _ready():
	sword = preload("res://scenes/Weapons/sword.tscn")
	initialChildCount = get_parent().get_child_count()

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
	if(mobInArea):
		hit_mob()
		
	move_and_slide()
	
func _on_area_2d_body_entered(body):
	if body.name.begins_with("mob"):
		mobInArea = true
		mobBody = body


func _on_area_2d_body_exited(body):
	if body.name.begins_with("mob"):
		mobInArea = false

func hit_mob():
	if(get_parent().get_child_count() <= initialChildCount):
		var s = sword.instantiate()
		get_parent().add_child(s)
		var swordPos = global_position
		var	mobAngle = atan2(mobBody.position.y - global_position.y, mobBody.position.x - global_position.x)
		s.rotation = mobAngle
		s.position = swordPos

