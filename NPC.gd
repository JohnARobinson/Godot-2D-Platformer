extends KinematicBody2D
onready var global = get_node("/root/Global")

var health = 10
var speed = 0
var velocity = Vector2()
var gravity = 10
var flor = Vector2(0, 440)
var direction = 1
var talk=0
var score = -5000
var check = 0

var timer = null

func _ready():
	var monster = get_node(".");
	get_node("talk").volume_db = global.sounds_v
	pass # Replace with function body.
	#get_node("talk").play()
	$Talkbox.visible = not $Talkbox.visible
	$NotTalk.visible = $NotTalk.visible
	$presse.set_text("move towards me")
	$movestuff.set_text("more stuff that way ----->")
	
	

func _physics_process(delta):
	#if health < 8:
	#	health = 10
	if health <= 0:
		$robonpc.play("ded")
		yield($robonpc, "animation_finished")
		if check < 1:
			add_score()

	
	var monster = get_node(".");
	velocity.x = speed*direction
	$robonpc.play("idle")

	move_and_slide(velocity*delta)
	velocity.y += gravity
	velocity = move_and_slide(velocity, flor)
	
	if talk == 1:
		$Talkbox.visible = $Talkbox.visible
		
func _on_talkingdistance_body_entered(body):
	var monster = get_node(".");
	#if Input.is_key_pressed(KEY_E):
	get_node("talk").play()
	$Talkbox.visible = true
	$NotTalk.visible = false
	$Talky.set_text("Hello, Advance through the level as fast as you can for the highest score!")
	talk = 1
	
	
		
func _on_talktime_timeout():
		$Talkbox.visible = false
		$Talky.set_text(" ")

func add_score():
	check= check+1
	global.score= global.score + score
	queue_free()
