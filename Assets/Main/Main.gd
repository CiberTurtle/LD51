extends Node2D

func _process(delta):
	if Input.is_action_just_pressed('menu'):
		$Menu.visible = !$Menu.visible

func _on_ResumeButton_pressed():
	closeMenu()

func _on_CampfireButton_pressed():
	Vars.player.respawn_me()
	closeMenu()

func _on_TorchButton_pressed():
	Vars.player.relight()
	closeMenu()

func closeMenu():
	$Menu.visible = false
