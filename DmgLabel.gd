extends Label

class_name DmgLabel

func _ready():
	$Timer.start(1)
	
func _process(delta):
	global_position.y -= delta * 100
	modulate.a -= 1 * delta
	


func _on_timer_timeout():
	queue_free()
