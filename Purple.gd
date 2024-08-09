extends Projectile

var target = Vector2.ZERO
var angle = Vector2.ZERO
var speed = 400
var isPlayerReached = false



func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle()
	$Timer.start(2.5)
	$AnimatedSprite2D.play("letit")

func _physics_process(delta):
	if(!isPlayerReached):
		global_position += angle * speed * delta


func _on_area_entered(area):
	if(area.name == "hitBox"):
		$Timer.start(0.01)
		isPlayerReached = true
		


func _on_timer_timeout():
	if(isPlayerReached):
		$CollisionShape2D.disabled = true
		$AnimatedSprite2D.play("babah")
		await $AnimatedSprite2D.animation_finished
	queue_free()
