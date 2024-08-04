extends Node2D	
	
	
func _ready():
	$AnimatedSprite2D.play("attack")
	await $AnimatedSprite2D.animation_finished
	queue_free()
	
