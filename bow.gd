extends Weapon

var currentTargets = {}
var isReadyToShoot = true
var projectileAmount = 3
var cooldown = 1.7

func _ready():
	animationScene = preload("res://arrow.tscn")
	dmg = 5


func hit():
	if(!currentTargets.is_empty() && isReadyToShoot):
		shoot_nearest_targets()
		
		

func _on_area_2d_area_entered(area):
	if area.name == "mob":
		currentTargets[area] = 1



func _on_area_2d_area_exited(area):
	if area.name == "mob":
		currentTargets.erase(area)
		
		

func shoot_nearest_targets():
	var targetDistances = []
	for target in currentTargets.keys():
		targetDistances.append([global_position.distance_to(target.global_position), target])
	
	targetDistances.sort()
	for i in range(projectileAmount):
		if(i > targetDistances.size() - 1):
			break
		var nearestTarget = targetDistances[i][1]
		if nearestTarget: 
			var arrow = animationScene.instantiate()
			arrow.target = nearestTarget.global_position
			arrow.dmg = calculateDamage()
			arrow.global_position = global_position
			get_parent().get_parent().add_child(arrow)
			
	$Timer.start(cooldown)
	isReadyToShoot = false
	
	
func _on_timer_timeout():
	isReadyToShoot = true
