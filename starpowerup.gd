extends Area2D
var savebase = 0
var timer =0

func _on_Timer_timeout():
	timer=1

func _on_maybe_powerup_star__Copy_body_entered(body):
	
	#body.speed = 6
	body.GRAVITY = 15


	$CollisionShape2D.disabled = true
	$Sprite.visible = false
	if(timer>0):
		body.speed = 4
