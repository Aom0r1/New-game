extends Area2D

class_name Xp

var xp = 0
var playerEntered = false
var startY = 0;
var time = 0.0
var isPlayerPickingUp = false
var player = null


func _ready():
	$AnimatedSprite2D.play("default")
	$Timer.start(30)
	startY = global_position.y 


func _process(delta):
	if(!isPlayerPickingUp):
		time += delta
		position.y = startY + scale.x * 5 * sin((1 + scale.x) * time)
	elif(player != null):
		moveTowardPlayer(player.global_position, delta)

func _on_timer_timeout():
	queue_free()
	

func moveTowardPlayer(PlayerPos, delta):
	var angle = global_position.direction_to(PlayerPos)
	global_position += angle * delta * 350


func _on_area_entered(area):
	if(area.name == "xpPickUpArea"):
		player = area.owner
		isPlayerPickingUp = true
