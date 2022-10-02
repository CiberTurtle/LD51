extends Area2D

const Player = preload("res://Assets/Player/Player.gd")

export var strength = 400
export var snapDirection = true

func _on_Bumper_body_entered(body):
	var player = body as Player
	# Skip non players
	if not player: return
	var diff = player.global_position - global_position;
	var dir = diff.normalized()

	print(diff)
	print(dir)

	# Apply velocity
	player.hExtraSpeed = dir.x * strength
	player.vSpeed = dir.y * strength
	player.coyoteTimer = -1

	# $AnimationPlayer.play('Spring Bounce')
	# $AudioStreamPlayer2D.play()
