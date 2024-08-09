extends Node2D

@export var mageMob = PackedScene
@export var zombikMob = PackedScene
@export var zCooldown = 5
@export var mCooldown = 15
@export var spawn_area_size = Vector2(1916, 1465)
var enemyType = typeof(zombikMob)

func _ready():
	mageMob = preload("res://mageMob.tscn")
	zombikMob = preload("res://zombikMob.tscn")
	add_zombikMob()
	add_mageMob()

func add_zombikMob():
	var zombikMobInstance = zombikMob.instantiate()
	zombikMobInstance.position = await get_random_cords()
	get_parent().add_child(zombikMobInstance)
	$z_cooldown.start(zCooldown)

func add_mageMob():
	var mageMobInstance = mageMob.instantiate()
	mageMobInstance.position = await get_random_cords()
	get_parent().add_child(mageMobInstance)
	$m_cooldown.start(mCooldown)
	
	

func check_cords(cords: Vector2):
	for e in get_parent().get_children():
		if(e is iMob):
			if(abs(cords.x - e.position.x) <= 50):
				return false
			if(abs(cords.y - e.position.y) <= 50):
				return false
	return true

func get_random_cords():
	var cords = Vector2(randi() % int(spawn_area_size.x), randi() % int(spawn_area_size.y))
	while not check_cords(cords):
		await get_tree().create_timer(0.1).timeout
		cords = Vector2(randi() % int(spawn_area_size.x), randi() % int(spawn_area_size.y))
	return cords

func _on_timer_timeout():
	add_zombikMob()

func _on_m_cooldown_timeout():
	add_mageMob()
