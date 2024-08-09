extends iMob

var character = null


func ready():
	character = $"../Character"
	$AnimatedSprite2D.play("running")
	hp = 20
	maxHp = 20
	speed = 200
	xp = 83
	baseDamage = 1
	evaisonChance = 5
	armor = 1


func logic(_delta):

	var direction = (character.position - self.position).normalized()
	velocity = direction * speed
	
	if velocity.x < 0:
		$AnimatedSprite2D.set_flip_h(true)	
	elif velocity.x > 0:
		$AnimatedSprite2D.set_flip_h(false)
	move_and_slide()

	

func die():
	$mob/CollisionShape2D2.disabled = true
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	dropXp()
	queue_free()
	
