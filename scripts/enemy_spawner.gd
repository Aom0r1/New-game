extends Node2D

@export var enemy = PackedScene
@export var cooldown = 5
@export var spawn_area_size = Vector2(1916, 1465)

var enemies = [{"chance": 10, "scene": preload("res://mageMob.tscn")}, {"chance": 100, "scene": preload("res://zombikMob.tscn")}]


func _ready():
	add_enemy()

func add_enemy():
	
	var randNum = randi() % 100
	for enemy in enemies: 
		if(randNum <= enemy["chance"]):
			var enemyInstance = enemy["scene"].instantiate()
			enemyInstance.position = await get_random_cords()
			get_parent().add_child(enemyInstance)
			$Timer.start(cooldown)
			break

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
	add_enemy()
