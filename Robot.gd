extends KinematicBody2D
onready var global = get_node("/root/Global")

const plasmashoot = preload("plasmaball.tscn")
var speed = 0
var velocity = Vector2()
var gravity = 10
var flor = Vector2(0, 440)
var direction = 1
var timer
var wait
var soundbox = 0
var robscore = 500
var check = 0

var health = 4

func _ready():
	var robot = get_node(".");
	#$robotshootinganim.frame == 0
	wait = 3
	#get_node("pewfire").play()
	#timer = Timer.new()
	#timer.set_one_shot(true)
	#timer.set_wait_time(wait)
	#timer.connect("timeout", self, "_on_timeout")
	#timer.set_timer_process_mode(0)
	#timer.start()

#func _on_timeout():
	#print("timeout")
	#var plas = plasmashoot.instance()
	#$robotshootinganim.play("robotfire")
	#get_node("pewfire").play()
	#add_child(plas)
	#pass



func _physics_process(delta):
	if health <= 0:
		$robotshootinganim.play("death")
		yield($robotshootinganim, "animation_finished")
		if check < 1:
			add_score()

	var robot = get_node(".");
	robot.get_node("robotshootinganim").flip_h = true
	velocity.x = speed*direction
	if health > 0:
		$robotshootinganim.play("robotfire")
	
	
	move_and_slide(velocity*delta)
	velocity.y += gravity
	velocity = move_and_slide(velocity, flor)
	
	if is_on_wall():
		direction = direction * -1
		
#func _process(delta):
	
	#var robot = get_node(".");
	#if($robotshootinganim.frame == 1):
	#	robot.get_node("pewfire").play()
	#	var plas = plasmashoot.instance()
	#	add_child(plas)
	
func _on_shootysoundbox_body_entered(body):
	if body.is_in_group("Player"):
		soundbox=1
		


func _on_shootysoundbox_body_exited(body):
	if body.is_in_group("Player"):
		soundbox=0
		
func _on_shootdelay_timeout():
	var robot = get_node(".");
	#$robotshootinganim.animation = "robotfire"
	#if($robotshootinganim.frame == 1):
	if(soundbox>0):
		robot.get_node("pewfire").play()
	var plas = plasmashoot.instance()
	add_child(plas)
	
func add_score():
	check= check+1
	global.score= global.score + robscore
	queue_free()

