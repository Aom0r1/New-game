extends Entity

class_name iMob



@export var maxHp = 0
@export var hp = 0
@export var speed = 0
@export var xp = 0
@export var baseDamage = 0
@export var armor = 0
@export var evaisonChance = 0
var xpScene = preload("res://xp.tscn")
var dmgScene = preload("res://DmgLabel.tscn")
var standartModulate = Color(modulate)
var isDead = false
var spawnVec = [Vector2(30,randi()%30), Vector2(60, randi()%30), Vector2(90, randi()%30)]

var knockBackPos = null
var knockBackDir = null
var knockBackProjectile = null


func _process(delta):
	if(!isDead):
		if(knockBackPos):
			if(global_position.distance_to(knockBackPos) < 1):
				knockBackPos = null
				knockBackDir = null
			else:
				global_position += delta * knockBackDir * speed / 2
		else:
			logic(delta)


func logic(delta):
	pass


func calculateRealDamage(dmg):
	if(randi()%100 <= evaisonChance):
		return 0
	
	var result = dmg
	result -= armor
	
	return result

func _on_area_2d_area_entered(area):
	if area is Projectile && area.team != team:
		if(!isDead && area != knockBackProjectile):
			if(!knockBackPos):
				knockBackProjectile = area
				knockBackDir = area.global_position.direction_to(global_position)
				knockBackPos = global_position + (knockBackDir * area.knockBack)
			hp -= area.dmg
			showDmgLabel(calculateRealDamage(area.dmg))
			modulate = Color('red')
			$ColorTimer.start(0.075)
		if(hp <= 0 && !isDead):
			isDead = true
			die()
		

func showDmgLabel(dmg):
	var dmgLabel = dmgScene.instantiate()
	dmgLabel.text = str(dmg)
	if(dmg <= 0):
		dmgLabel.text = "miss"
	dmgLabel.global_position = global_position
	var dmgHpRatio = float(dmg) / maxHp
	var colorGB = 1.0 - dmgHpRatio
	dmgLabel.modulate = Color(1, colorGB, colorGB)
	var scaleMul = 1.0 + dmgHpRatio
	dmgLabel.scale *= scaleMul
	get_parent().add_child(dmgLabel)		

func die():
	dropXp()

	
func dropXp():
	var xpInstancesAmount = randi()%3 + 1
	var xpTempAmount = xp
	
	for i in range(xpInstancesAmount):
		if(xp <= 0):
			break
		var xpInstance = xpScene.instantiate()
		var tempXp = 0
		if(i == xpInstancesAmount - 1):
			tempXp = xp
		else:
			tempXp = randi() % xp
		xpInstance.xp = tempXp
		xp -= tempXp
		xpTempAmount -= 1
		xpInstance.global_position = global_position + spawnVec[i]
		var ratio = float(float(tempXp) / float(xpTempAmount) * 0.5) + 1
		var scaleVec = Vector2(ratio, ratio)
		xpInstance.apply_scale(scaleVec)
		get_parent().add_child(xpInstance)


func _on_color_timer_timeout():
	modulate = standartModulate
