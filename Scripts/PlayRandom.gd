extends Node

export var volume = 0.0
export var volume_var = 0.2

export var pitch = 1.0
export var pitch_var = 0.05

var rng = RandomNumberGenerator.new()

func play():
	var children = get_children()
	var player = children[rng.randi_range(0, children.size() - 1)] as AudioStreamPlayer2D;

	player.pitch_scale = pitch + rng.randf_range(-pitch_var/2, pitch_var/2);
	player.volume_db = volume + rng.randf_range(-volume_var/2, volume_var/2);
	player.play()
