extends Area2D

const Player = preload("res://Assets/Player/Player.gd")

export var hSpeed = 600
export var vSpeed = -400

func _ready():
	$Flip.scale.x = sign(hSpeed);

func _on_Area2D_body_entered(body):
	var player = body as Player
	if not player: return

	player.hExtraSpeed = hSpeed
	player.vSpeed = vSpeed
