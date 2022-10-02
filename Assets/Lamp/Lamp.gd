extends Area2D

signal on
signal off

export(NodePath) var node
onready var _node = get_node(node) as Area2D

export var time = 10.0
var timer = 0.0
var lerpedTimer = 0.0

export var is_on = false

var ogLayer = 0;
var ogMask = 0

func _ready():
	update()
	ogLayer = _node.collision_layer
	ogMask = _node.collision_mask

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

	_node.monitoring = is_on
	_node.monitorable = is_on

	_node.visible = is_on
	$On.visible = is_on
	$Off.visible = !is_on
