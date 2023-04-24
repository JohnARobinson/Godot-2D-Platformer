extends Area2D

onready var p_var = get_node("/root/PlayerVars")

var speed = 420
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	position += transform.x * speed * delta * direction

func _on_RTCat_body_entered(body):
	if "monster" in body.name or "Robot" in body.name or "plasma" in body.name:
		body.health = body.health - 1
		#body.health <= 0 :
			#body.queue_free()
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	p_var.shots_left = p_var.shots_left + 1
	queue_free()
