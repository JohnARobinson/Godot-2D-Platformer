extends KinematicBody2D
var speed = 50
var velocity = Vector2()
var gravity = 10
var flor = Vector2(0, 440)
var direction = 1

var timer = null

func _ready():
	var boi = get_node(".");
	pass # Replace with function body.
	get_node("AudioStreamPlayer").play()
	
	

func _physics_process(delta):
	var boi = get_node(".");
	velocity.x = speed*direction
	$AnimatedSprite.play("rollin")
	
	move_and_slide(velocity*delta)
	velocity.y += gravity
	velocity = move_and_slide(velocity, flor)
	
	if direction == 1:
		boi.get_node("AnimatedSprite").flip_h = true
	else:
		boi.get_node("AnimatedSprite").flip_h = false
	
	if is_on_wall():
		direction = direction * -1

