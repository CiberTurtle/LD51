extends Area2D

export var is_on = false

func _ready():
	update()

func update():
	$On.visible = is_on
	$Off.visible = !is_on
	$On/Sound.playing = is_on

	if is_on:
		$IgniteSound.play()
