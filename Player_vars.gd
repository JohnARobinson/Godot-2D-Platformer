extends Node

var health = 3
var jump_height = 800
var speed = 4
var shots_left = 3
var vulnerable = true

# 1 = stable, 2 = recovery, 3 = hit
var state = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
