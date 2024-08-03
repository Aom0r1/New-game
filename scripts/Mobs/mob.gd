extends CharacterBody2D

var pos = self.global_position

@export var hp = 9999
@export var speed = 200.0

func _ready():
	$AnimatedSprite2D.play("running")

func _physics_process(delta):
	var character = $"../Character"
	var direction = (character.position - self.position).normalized()
	velocity = direction * speed
	
	if velocity.x < 0:
		$AnimatedSprite2D.set_flip_h(true)	
	elif velocity.x > 0:
		$AnimatedSprite2D.set_flip_h(false)
	
	if hp == 0:
		$AnimatedSprite2D.play("death")
		await $AnimatedSprite2D.animation_finished
		queue_free()
	
	
	
	move_and_slide()

		
func _on_area_2d_area_entered(area):
	if area.name == "AreaSword":
		hp -= area.dmg
