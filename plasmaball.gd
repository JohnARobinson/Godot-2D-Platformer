extends Area2D
onready var p_var = get_node("/root/PlayerVars")

var speed = 300
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	position -= transform.x *speed * delta

func _on_plasmaball_body_entered(body):
	if !body.is_in_group("monster") and !body.is_in_group("powerup"):
			speed = 0
			$Sprite.visible = false
			$contact.play("impact")
			yield($contact, "animation_finished")
			queue_free()
	if body.is_in_group("Proj"):
		queue_free()
	if body.is_in_group("Player"):
		if p_var.vulnerable == true:
			p_var.health = p_var.health - 1
			if p_var.health <= 0:
				p_var.state = 4
			else:
				p_var.state = 3
				p_var.vulnerable = false
