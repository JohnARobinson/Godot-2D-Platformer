extends KinematicBody2D
onready var global = get_node("/root/Global")

var speed = 50
var velocity = Vector2()
var gravity = 10
var flor = Vector2(0, 440)
var direction = 1
var health = 3
var monscore = 500
var check = 0

var timer = null

func _ready():
	var monster = get_node(".");
	get_node("growl").volume_db = global.sounds_v

func _physics_process(delta):
	if health <= 0:
		$AnimatedSprite.play("dead")
		yield($AnimatedSprite, "animation_finished")
		if check < 1:
			add_score()
	var monster = get_node(".");
	velocity.x = speed*direction
	$AnimatedSprite.play("monsteridle")
	
	
	
	move_and_slide(velocity*delta)
	velocity.y += gravity
	velocity = move_and_slide(velocity, flor)
	
	if is_on_wall():
		direction = direction * -1
	

func _on_musiccheck_body_entered(body):
	if body.is_in_group("Player"):
		get_node("slimey").play()
		get_node("growl").play()


func _on_musiccheck_body_exited(body):
	if body.is_in_group("Player"):
		get_node("slimey").stop()
		get_node("growl").stop()
func add_score():
	check= check+1
	global.score= global.score + monscore
	queue_free()



func _on_Timer_timeout():
	get_node("growl").play()
