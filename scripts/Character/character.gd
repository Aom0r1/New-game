extends CharacterBody2D

var fps_label: Label
@export var sword = PackedScene
@export var hp = 20
@export var speed = 300.0
var lastDir
var currentTargets = {}
var swordInstance = null



func _ready():
	fps_label = $Camera2D/CanvasLayer/Label2
	sword = preload("res://scenes/Weapons/sword.tscn")

func _process(delta):
	var fps = Engine.get_frames_per_second()
	fps_label.text = "FPS: " + str(fps)

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

	if not currentTargets.is_empty():
		attack_nearest_target()

	move_and_slide()

func _on_area_2d_area_entered(area):
	if area.name == "mob":
		currentTargets[area] = 1

func _on_area_2d_area_exited(area):
	if area.name == "mob":
		currentTargets.erase(area)

func attack_nearest_target():
	var nearestTarget = get_nearest_target()
	if nearestTarget and swordInstance == null:
		swordInstance = sword.instantiate()
		get_parent().add_child(swordInstance)
	if swordInstance != null:
		update_sword_position_and_rotation(nearestTarget)

func update_sword_position_and_rotation(target):
	var swordPos = global_position
	var targetAngle = atan2(target.global_position.y - global_position.y, target.global_position.x - global_position.x)
	swordInstance.rotation = targetAngle
	swordInstance.global_position = swordPos

func get_nearest_target():
	var nearestTarget = null
	var minimumDistance = null
	for target in currentTargets.keys():
		var currentDistance = global_position.distance_to(target.global_position)
		if minimumDistance == null or currentDistance < minimumDistance:
			minimumDistance = currentDistance
			nearestTarget = target
	return nearestTarget
