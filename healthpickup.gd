extends Area2D
onready var p_var = get_node("/root/PlayerVars")

var savebase = 0
var timer =0

func _on_Timer_timeout():
	timer=1


func _on_healthheartpng__Copy_body_entered(body):
	if(p_var.health < 3 and p_var.health >0):
		p_var.health = p_var.health + 1
		queue_free()


	$CollisionShape2D.disabled = true
	$Sprite.visible = false
	if(timer>0):
		body.speed = 4
