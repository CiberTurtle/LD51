extends Area2D

signal on
signal off

export var time = 10.0

export(Array, NodePath) var turnOn = []
export(Array, NodePath) var turnOff = []

export var offAlpha = 0.35;

var timer = 0.0
var lerpedTimer = 0.0

export var is_on = false

func _ready():
	update_fire(false)

func _process(delta):
	lerpedTimer = move_toward(lerpedTimer, timer, delta * 50)

	lerpedTimer = max(lerpedTimer, 0)
	var v = lerpedTimer / time;
	$On/Value.scale = Vector2(v, v)

func _physics_process(delta):
	timer -= delta

	if timer > 0 != is_on:
		is_on = timer > 0
		update_fire(true)

func light():
	if timer < time * 0.67:
		$IgniteSound.play()
	timer = time

func update_fire(soundOn: bool):
	is_on = timer > 0

	if is_on:
		emit_signal('on')
		if soundOn: $OnSound.play()
	else:
		emit_signal('off')
		if soundOn: $OffSound.play()

	if soundOn: $Puff.restart()
	# $Puff.emitting = true

	set_things(turnOn, is_on)
	set_things(turnOff, !is_on)

	$On.visible = is_on
	$Off.visible = !is_on

func set_things(paths: Array, state: bool):
	for path in paths:
		var obj = get_node(path) as CollisionObject2D
		# obj.visible = state
		obj.modulate = Color(1.0, 1.0, 1.0, 1.0 if state else offAlpha)
		obj.set_collision_layer_bit(0, state)
		obj.set_collision_mask_bit(0, state)
