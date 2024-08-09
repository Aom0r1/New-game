extends Entity


var fps_label: Label
@export var sword = PackedScene
@export var hp = 20
@export var speed = 300.0
var lastDir
var xpAmount = 0





func _ready():
	fps_label = $Camera2D/CanvasLayer/Label2
	team = teamNumber.player
	

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
	
	$bow.hit()
	$Sword.hit()
	move_and_slide()




func _on_area_2d_area_entered(area):
	if(area is Xp):
		xpAmount += area.xp
		area.queue_free()
		print(xpAmount)
	elif(area.name == "mob"):
		hp -= area.owner.baseDamage
	elif(area is Projectile && area.team != team):
		hp -= area.dmg

		
	
