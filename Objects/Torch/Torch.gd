extends Area2D

export var time = 10.0
var timer = 0.0
var lerpedTimer = 0.0
var is_on = false

func _ready():
	update()
	
func _process(delta):
	if(Input.is_action_just_pressed("debug_relight")):
		timer = time
	
	lerpedTimer = move_toward(lerpedTimer, timer, delta * 50)
	
	var v = lerpedTimer / time
	$On/Value.scale = Vector2(v, v);

func _physics_process(delta):
	timer -= delta;
	
	if(timer > 0 != is_on):
		is_on = timer > 0
		update()

func update():
	$On.visible = is_on
	$Off.visible = !is_on
