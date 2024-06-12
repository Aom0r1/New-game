extends Node2D

func _on_area_2d_body_entered(body):
	if body.name == "mob":
		$AnimatedSprite2D.play("attack")
		await $AnimatedSprite2D.animation_finished
		queue_free()
