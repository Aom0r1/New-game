extends Node2D

class_name Weapon

@export var animationScene : PackedScene

var dmg = 0
var critMultiplier = 0.0
var critChance = 0


func hit():
	pass

func calculateDamage():
	var result  = 0
	result += dmg 
	
	if(randi()%100 <= critChance):
		result *= critMultiplier
	
	return result

