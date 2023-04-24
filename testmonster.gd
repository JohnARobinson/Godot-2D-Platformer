extends Node2D

onready var monster = preload("res://monster.tscn")
onready var robot = preload("res://Robot.tscn")
onready var robotnpc = preload("res://RobotNPC.tscn")
onready var player = preload("res://Player.tscn")
onready var boi = preload("res://whodatboi.tscn")

func _ready():
	var newmonster = monster.instance()
	add_child(newmonster)
	
	newmonster.position = Vector2(600, 200)
	
	#var newboi = boi.instance()
	#add_child(newboi)
	
	#newboi.position = Vector2(200, 200)
	
	
	
	
	
	
	var newrobot = robot.instance()
	add_child(newrobot)
	
	newrobot.position = Vector2(900, 200)
	
	var newplayer = player.instance()
	add_child(newplayer)
	
	newplayer.position = Vector2(1300, 200)
	
	var newrobotnpc = robotnpc.instance()
	add_child(newrobotnpc)
	
	newrobotnpc.position = Vector2(1700, 250)
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
