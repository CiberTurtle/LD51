extends Area2D

const Player = preload("res://Assets/Player/Player.gd")

export var strength = 400
export var snapDirection = true

export var idleSpeed = 1.0
export var boostSpeed = 8.0
export var speedDec = 2.0

var speed = 0;

func _ready():
	$AnimationPlayer.play('Idle')

func _process(delta):
	$Art/Plus.rotation += speed * TAU * delta
	speed = move_toward(speed, idleSpeed, speedDec * delta);

func _on_Boost_body_entered(body):
	var player = body as Player
	# Skip non players
	if not player: return

	# Apply velocity
	player.hExtraSpeed = sign(player.hMoveSpeed) * strength
	player.vSpeed = sign(player.vSpeed) * strength
	player.coyoteTimer = -1

	speed = boostSpeed

	$AudioStreamPlayer2D.play()
	$CPUParticles2D.emitting = true;
