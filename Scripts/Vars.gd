extends Node

const Player = preload("res://Assets/Player/Player.gd")
var player: Player = null

export var eggGoal = 3

var eggsOnHand = 0
var eggsDeposited = 0

var eggsCollectedToltal = 0;

const Campfire = preload("res://Assets/Campfire/Campfire.gd")
var lastCampfire: Campfire = null
