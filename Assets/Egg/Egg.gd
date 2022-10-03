extends Node2D

export var followSpeed = 300

var follow: Node2D

func _physics_process(delta):
	if follow:
		var x = move_toward(global_position.x, follow.global_position.x, followSpeed * delta);
		var y = move_toward(global_position.y, follow.global_position.y, followSpeed * delta);	
		global_position = Vector2(x, y)

func follow_player():
	follow = Vars.player
	
func goto_nest(nest: Node2D):
	follow = nest
