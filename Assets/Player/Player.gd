extends KinematicBody2D

const Egg = preload("res://Assets/Egg/Egg.gd")

export var eggRequirement = 3

export var moveInc = 32.0
export var moveDec = 16.0
export var moveIncAir = 24.0
export var moveDecAir = 8.0
export var moveMax = 128.0

export var extraDec = 12.0
export var extraDecAir = 6.0

export var jumpHeightMin = 16.0
export var jumpHeightMax = 40.0

export var gravity = 12.0
export var fallMax = 360.0

export var coyoteTime = 0.1
export var jumpBufferTime = 0.1

var coyoteTimer = -1.0
var jumpBufferTimer = -1.0

export var stepTime = 0.2
export var stepTimeVar = 0.025
var stepTimer = 0

func _ready():
	Vars.player = self

func _process(delta):
	get_input()

var hExtraSpeed = 0.0
var hMoveSpeed = 0.0
var vSpeed = 0.0
func _physics_process(delta):
	if respawn:
		respawn_me()
	respawn = false
	do_move(delta)
	do_grav(delta)
	do_jump(delta)

	move_and_slide(Vector2(hMoveSpeed + hExtraSpeed, vSpeed), Vector2(0, -1));

func do_move(delta):
	var grounded = is_on_floor();

	if(inputMoveDir != 0): # Speeding up
		hMoveSpeed += inputMoveDir * (moveInc if grounded else moveIncAir);
		hMoveSpeed = clamp(hMoveSpeed, -moveMax, moveMax);
		$Flip.scale.x = inputMoveDir;

		if grounded:
			stepTimer -= delta
			if stepTimer < 0:
				stepTimer = stepTime
				$Step/Grass.play()
	else: # Slowing down
		hMoveSpeed = move_toward(hMoveSpeed, 0, (moveDec if grounded else moveDecAir));

	if(is_on_wall()):
		hMoveSpeed = 0
		hExtraSpeed = 0

	hExtraSpeed = move_toward(hExtraSpeed, 0, (extraDec if grounded else extraDecAir));

func do_grav(delta):
	if(is_on_ceiling()):
		# Hit ceiling so stop going up
		if vSpeed < 0: vSpeed = 0

	if(is_on_floor()):
		# Hit floor so stop falling
		if vSpeed > 0:
			vSpeed = 0
			if vSpeed > gravity * 8: $Step/Grass.play()
	else:
		# Fall
		vSpeed += gravity

		# Clamp fall speed for greater control
		if(vSpeed > fallMax):
			vSpeed = fallMax

func do_jump(delta):
	if(is_on_floor()):
		coyoteTimer = coyoteTime

	if(jumpBufferTimer > 0 and coyoteTimer > 0):
		jumpBufferTimer = -1
		coyoteTimer = -1

		# Jump
		var jumpSpeedMax = -sqrt(2 * (gravity / delta) * jumpHeightMax)
		vSpeed = jumpSpeedMax
	jumpBufferTimer -= delta;
	coyoteTimer -= delta;

	if(inputJumpCancel):
		# Cancel jump
		var jumpSpeedMin = -sqrt(2 * (gravity / delta) * jumpHeightMin)
		if(vSpeed < jumpSpeedMin):
			vSpeed = jumpSpeedMin
	inputJumpCancel = false

var inputMoveDir = 0.0
var inputJumpCancel = false
var respawn = false
func get_input():
	inputMoveDir = sign(Input.get_axis("move_left", "move_right"))
	if(Input.is_action_just_pressed("move_jump")):
		jumpBufferTimer = jumpBufferTime

	if(Input.is_action_just_released("move_jump")):
		inputJumpCancel = true

	if Input.is_action_just_pressed("debug_respawn"):
		respawn = true

func say(text: String):
	var charTime = 1.0 / 30

	$Say/Text.text = text
	$Say/Tween.interpolate_property($Say/Text, 'percent_visible', 0, 1, text.length() * charTime)
	$Say/Tween.start()
	$Say/Text.visible = true

func _on_Tween_tween_completed(object, key):
	# var text = $Say/Text.text
	# var charTime = 1.0 / 8

	$Say/Timer.start(5)

func _on_Timer_timeout():
	$Say/Text.visible = false

func pickup():
	var v = Vars.eggsCollectedToltal
	if v == 1:
		$PickupSound/Pickup1.play()
	else: if 2:
		$PickupSound/Pickup2.play()
	else: if 3:
		$PickupSound/Pickup3.play()

func drop():
	var v = Vars.eggsDeposited
	if v == 1:
		$DropSound/Pickup1.play()
	else: if 2:
		$DropSound/Pickup2.play()
	else: if 3:
		$DropSound/Pickup3.play()

func respawn_me():
	if Vars.lastCampfire:
		global_position = Vars.lastCampfire.global_position - Vector2(0, 0)
		hMoveSpeed = 0
		hExtraSpeed = 0
		vSpeed = 0

func relight():
	$Flip/Torch.timer = $Flip/Torch.time
