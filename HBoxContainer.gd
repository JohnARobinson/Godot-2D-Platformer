extends HBoxContainer
onready var p_var = get_node("/root/PlayerVars")
var hp
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	hp = p_var.health
	if hp == 3:
		$h3.visible = true
		$h2.visible = false
		$h1.visible = false
	if hp == 2:
		$h3.visible = false
		$h2.visible = true
		$h1.visible = false
	if hp < 2:
		$h3.visible = false
		$h2.visible = false
		$h1.visible = true
	if hp < 1:
		$h1.visible = false
		$h3.visible = false
		$h2.visible = false
		$ded.visible = true
