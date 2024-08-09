extends iMob

var character = null
var bulik = preload("res://purple.tscn")


enum states{
	attack, runningFrom, runningTo, castingSpell
}


var state = states.attack

func ready():
	character = $"../Character"
	$AnimatedSprite2D.play("running")
	hp = 40
	maxHp = 40
	speed = 200
	xp = 83
	baseDamage = 0
	evaisonChance = 5
	armor = 1
	

func die():
	dropXp()
	queue_free()

func logic(_delta):
	
	var direction = Vector2.ZERO
	isPlayerToClose()
	
	if(state == states.runningTo):
		direction = global_position.direction_to(character.global_position)
	elif(state == states.runningFrom):
		direction = character.global_position.direction_to(global_position)
	elif(state == states.attack):
		$CoolDownTimer.start(3)
		state = states.castingSpell
		
	velocity = direction * speed
	
	if velocity.x < 0:
		$AnimatedSprite2D.set_flip_h(true)	
	elif velocity.x > 0:
		$AnimatedSprite2D.set_flip_h(false)
	elif(state == states.castingSpell):
		$AnimatedSprite2D.play("idle")
		
		
	move_and_slide()

func isPlayerToClose():
	if(state == states.castingSpell):
		return
	
	if(global_position.distance_to(character.position) < 400):
		state = states.runningFrom
	elif(global_position.distance_to(character.position) > 550):
		state = states.runningTo
	else:
		state = states.attack


func _on_cool_down_timer_timeout():
	var bulikInstance = bulik.instantiate()
	bulikInstance.target = character.global_position
	bulikInstance.dmg = 3
	bulikInstance.team = team
	bulikInstance.global_position = global_position
	get_parent().add_child(bulikInstance)
	state = states.runningFrom
	$CoolDownTimer.stop()
