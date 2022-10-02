extends Area2D

const Player = preload("res://Assets/Player/Player.gd")

export var hSpeed = 600
export var vSpeed = -400

func _on_Area2D_body_entered(body):
	var player = body as Player
	# Skip non players
	if not player: return

	# Apply velocity
	player.hExtraSpeed = hSpeed
	player.vSpeed = vSpeed
	player.coyoteTimer = -1

	$AnimationPlayer.play('Spring Bounce')
	$AudioStreamPlayer2D.play()
