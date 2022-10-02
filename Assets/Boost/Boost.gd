extends Area2D

const Player = preload("res://Assets/Player/Player.gd")

export var strength = 400
export var snapDirection = true

func _on_Boost_body_entered(body):
	var player = body as Player
	# Skip non players
	if not player: return

	# Apply velocity
	player.hExtraSpeed = sign(player.hMoveSpeed) * strength
	player.vSpeed = sign(player.vSpeed) * strength
	player.coyoteTimer = -1

	# $AnimationPlayer.play('Spring Bounce')
	# $AudioStreamPlayer2D.play()
