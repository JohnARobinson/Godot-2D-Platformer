extends Label
onready var m_var = get_node("/root/monster1")
onready var r_var = get_node("/root/Robot")
onready var c_var = get_node("/root/RobotNPC")
onready var global = get_node("/root/Global")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	global.score = 10000
	pass # Replace with function body.

func _process(_delta):
	global.score -= 1
	text =str(global.score)
