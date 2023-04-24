extends Node


onready var p_var = get_node("/root/PlayerVars")


var music_v = 0
var temp_m = 0
var mute = false
var sounds_v = 0
var score = 10000
var highscore = 0
var state = 0
signal deathrobot
signal deathmonster
signal deathnpc
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if mute == true and state == 0:
		temp_m = music_v
		music_v = -100
		state = 1
	
	if mute == false and state == 1:
		music_v = temp_m
		state = 0

func reset():
	get_tree().change_scene("res://Title_Screen.tscn")
	p_var.health = 3
	p_var.jump_height = 800
	p_var.speed = 4
	p_var.shots_left = 3
	p_var.state = 1
	p_var.vulnerable = true
