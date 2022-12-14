extends Area2D

const Campfire = preload("res://Assets/Campfire/Campfire.gd")
const EggTree = preload("res://Assets/EggTree/EggTree.gd")
const Lamp = preload("res://Assets/Lamp/Lamp.gd")

export var time = 10.0
var timer = 0.0
var lerpedTimer = 0.0
var is_on = false

func _ready():
	update()

func _process(delta):
	if Input.is_action_just_pressed("debug_relight"):
		timer = time

	lerpedTimer = move_toward(lerpedTimer, timer, delta * 50)

	lerpedTimer = max(lerpedTimer, 0)

	var v = lerpedTimer / time
	$On/Value.scale = Vector2(v, v);

func _physics_process(delta):
	timer -= delta;

	if timer > 0 != is_on:
		is_on = timer > 0
		update()

	for body in get_overlapping_areas():
		var fire = body as Campfire
		if fire:
			if fire.is_on:
				if timer < time - 0.4:
					$IgniteSound.play()
					Vars.lastCampfire = fire;
				timer = time
			else:
				if is_on:
					fire.is_on = true
					fire.update()
			return

		var tree = body as EggTree
		if tree:
			if is_on:
				tree.burn()
			return

		var lamp = body as Lamp
		if lamp:
			if is_on:
				lamp.light()
			return

func update():
	if is_on: $IgniteSound.play()
	$On.visible = is_on
	$Off.visible = !is_on
	$On/Sound.playing = is_on
	$Particles2D.emitting = is_on
