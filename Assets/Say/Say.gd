extends Area2D

const Player = preload("res://Assets/Player/Player.gd")

export var text = "Hello world"

var said = false

func _on_Say_body_entered(body):
	if said: return

	var player = body as Player
	# Skip non players
	if not player: return

	said = true

	player.say(text)
