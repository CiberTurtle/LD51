extends KinematicBody2D

export var moveInc = 32.0
export var moveDec = 16.0
export var moveIncAir = 24.0
export var moveDecAir = 8.0
export var moveMax = 128.0

export var jumpHeightMin = 16.0
export var jumpHeightMax = 40.0

export var gravity = 12.0
export var fallMax = 360.0

export var coyoteTime = 0.1
export var jumpBufferTime = 0.1

var coyoteTimer = -1.0
var jumpBufferTimer = -1.0

func _ready():
	pass

func _process(delta):
	get_input()

var hExtraSpeed = 0.0
var hMoveSpeed = 0.0
var vSpeed = 0.0
func _physics_process(delta):
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
	else: # Slowing down
		hMoveSpeed = move_toward(hMoveSpeed, 0, (moveDec if grounded else moveDecAir));
	
	if(is_on_wall()):
		hMoveSpeed = 0
		hExtraSpeed = 0
	
	hExtraSpeed = move_toward(hExtraSpeed, 0, (moveDec if grounded else moveDecAir));

func do_grav(delta):
	if(is_on_ceiling()):
		# Hit ceiling so stop going up
		vSpeed = 0
	
	if(is_on_floor()):
		# Hit floor so stop falling
		vSpeed = 0
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
		var jumpSpeedMin = -sqrt(2 * (gravity ) * jumpHeightMin)
		if(vSpeed < jumpSpeedMin):
			vSpeed = jumpSpeedMin
	inputJumpCancel = false

var inputMoveDir = 0.0
var inputJumpCancel = false
var inputPickup = false
func get_input():
	inputMoveDir = Input.get_axis("move_left", "move_right")
	if(Input.is_action_just_pressed("move_jump")):
		jumpBufferTimer = jumpBufferTime
	
	if(Input.is_action_just_released("move_jump")):
		inputJumpCancel = true
	
	if(Input.action_release("pickup")):
		inputPickup = true
