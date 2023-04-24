extends Node2D

onready var timer = 0;
onready var global = get_node("/root/Global")
onready var pvar = get_node("/root/PlayerVars")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("Music").playing = true
	var player = get_node("./Player")
	player.position = Vector2(25, 425)
	player.scale = Vector2(0.25, 0.25)
	get_node("Music").volume_db = global.music_v

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player = get_node("./Player")
	var endlevel = get_node("./Endoflevel");
	get_node("Music").volume_db = global.music_v
	#Checks if the player is close to the edge of the level...
	#Stops the camera from paning off the level
	if(player.position.x < 225):
		player.get_node("Camera2D").offset = Vector2(225 - player.position.x,0)
	if(player.position.x > 3850):
		player.get_node("Camera2D").offset = Vector2(3850 - player.position.x,0)
	if(player.position.y > 475):
		player.get_node("Camera2D").offset = Vector2(0, 450 - player.position.y)
		if(player.position.y > 575):
			pvar.state = 4
	
	
	timer += 1
	if(timer == 80):
		removPlat1()
	if(timer == 160):
		placePlat1()
		timer = 0

func placePlat1():
	var tilemap = get_node("./TileMap")
	tilemap.set_cell(190, 47, 16)
	tilemap.set_cell(192, 47, 16)
	tilemap.set_cell(194, 47, 16)

func removPlat1():
	var tilemap = get_node("./TileMap")
	tilemap.set_cell(190, 47, -1)
	tilemap.set_cell(192, 47, -1)
	tilemap.set_cell(194, 47, -1)


func _onEndLevelEnter(body):
	if(global.score > global.highscore):
		global.highscore = global.score
	global.reset()
	pass # End the level


func _on_levelbottom_body_entered(body):
	get_tree().change_scene("res://Title_Screen.tscn")
