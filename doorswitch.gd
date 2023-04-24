extends Node2D

var byterminal = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(byterminal == true && Input.is_action_pressed("ui_down")):
		terminalActive()
	
	if(get_parent().get_node("./Player").position.x > 3750):
		var text = get_node("./doortext")
		while(text.percent_visible < 1):
			text.percent_visible += 0.1

func terminalActive():
	var text = get_node("opentext")
	var doortxt = get_node("doortext")
	while(text.percent_visible < 1):
		text.percent_visible += 0.1
	#cover the door text
	doortxt.visible = false
	#open the door
	var tilemap = get_parent().get_node("TileMap")
	var doory = 42
	while(doory <= 56):
		tilemap.set_cell(477, doory, -1)
		doory += 2

func _on_terminalarea_body_entered(body):
	byterminal = true


func _on_terminalarea_body_exited(body):
	byterminal = false
