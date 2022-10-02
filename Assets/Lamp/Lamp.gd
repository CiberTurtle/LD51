extends Area2D

signal on
signal off

export var time = 10.0

export(Array, NodePath) var turnOn = []
export(Array, NodePath) var turnOff = []

var timer = 0.0
var lerpedTimer = 0.0

export var is_on = false

func _ready():
	update()

func _process(delta):
	lerpedTimer = move_toward(lerpedTimer, timer, delta * 50)

	lerpedTimer = max(lerpedTimer, 0)
	var v = lerpedTimer / time;
	$On/Value.scale = Vector2(v, v)

func _physics_process(delta):
	timer -= delta

	if timer > 0 != is_on:
		is_on = timer > 0
		update()

func light():
	timer = time

func update():
	is_on = timer > 0

	if is_on:
		emit_signal('on')
	else:
		emit_signal('off')

	set_things(turnOn, is_on)
	set_things(turnOff, !is_on)

	$On.visible = is_on
	$Off.visible = !is_on

func set_things(paths: Array, state: bool):
	for path in paths:
		var obj = get_node(path) as CollisionObject2D
		obj.visible = state
		obj.set_collision_layer_bit(0, state)
		obj.set_collision_mask_bit(0, state)
