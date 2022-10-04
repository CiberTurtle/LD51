extends Area2D

export var completed = false

func burn():
	if completed: return
	completed = true
	$OnFire.visible = true
	$Timer.start()
	$BurnSound.play()

func _on_Timer_timeout():
	$OnFire.visible = false
	$Before.visible = false
	$After.visible = true

	Vars.eggsOnHand += 1
	Vars.eggsCollectedToltal += 1
	Vars.player.pickup()

	if Vars.eggsCollectedToltal == 1:
		Vars.player.say("First egg down!")
	else: if Vars.eggsCollectedToltal == 2:
		Vars.player.say("One more to go!")
	else: if Vars.eggsCollectedToltal == 3:
		Vars.player.say("Finaly I found them all! I should head back to the cave...")
