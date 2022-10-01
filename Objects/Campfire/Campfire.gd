
extends Area2D

const Torch = preload("res://Objects/Torch/Torch.gd")

var is_on = false

func _ready():
	update()

func update():
	$On.visible = is_on
	$Off.visible = !is_on

func _on_Campfire_area_entered(area):
	var torch = area as Torch
	if not torch: return
	
	if(is_on):
		torch.timer = torch.time
	else:
		if torch.timer > 0:
			is_on = true
			update()
