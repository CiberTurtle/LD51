extends Area2D

export var completed = false

func burn():
	if completed: return
	completed = true
	$OnFire.visible = true
	$Timer.start()

func _on_Timer_timeout():
	$OnFire.visible = false
	$Before.visible = false
	$After.visible = true
