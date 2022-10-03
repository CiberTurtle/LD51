extends Area2D

const Player = preload("res://Assets/Player/Player.gd")

var hasEgg = false

func _on_Nest_body_entered(body):
	if hasEgg: return
	
	var player = body as Player
	if not player: return
	if Vars.eggsOnHand < 1: return
	
	Vars.eggsOnHand -= 1
	Vars.eggsDeposited += 1
	Vars.player.drop()
	
	hasEgg = true
	
	$Egg.visible = true
