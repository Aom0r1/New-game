extends "res://iWeapon.gd"

var currentTargets = {}
var swordInstance = null



func _ready():
	animationScene = preload("res://swordAnimation.tscn")
	dmg = 5
	critMultiplier = 4
	critChance = 25

func hit():
	if(!currentTargets.is_empty()):
		attack_nearest_target()
	

func _on_area_2d_area_entered(area):
	if area.name == "mob":
		currentTargets[area] = 1


func _on_area_2d_area_exited(area):
	if area.name == "mob":
		currentTargets.erase(area)


func attack_nearest_target():
	var nearestTarget = get_nearest_target()
	if nearestTarget and swordInstance == null:
		swordInstance = animationScene.instantiate()
		swordInstance.dmg = calculateDamage()
		swordInstance.knockBack = 30
		swordInstance.team = owner.team
		get_parent().get_parent().add_child(swordInstance)
		if swordInstance != null:
			update_sword_position_and_rotation(nearestTarget)


func update_sword_position_and_rotation(target):
	var swordPos = global_position
	var targetAngle = atan2(target.global_position.y - global_position.y, target.global_position.x - global_position.x)
	swordInstance.rotation = targetAngle
	swordInstance.global_position = swordPos
	


func get_nearest_target():
	var nearestTarget = null
	var minimumDistance = null
	for target in currentTargets.keys():
		var currentDistance = global_position.distance_to(target.global_position)
		if minimumDistance == null or currentDistance < minimumDistance:
			minimumDistance = currentDistance
			nearestTarget = target
	return nearestTarget
	
	
