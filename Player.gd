extends KinematicBody2D

onready var RTCat = preload("res://RTCat.tscn")
onready var global = get_node("/root/Global")
onready var p_var = get_node("/root/PlayerVars")

var GRAVITY = 25
const JUMP = Vector2(0,-1)

var velocity = Vector2(0,600)
var direction = 1
var land_var = 1
var jump = 1
var start_timer = true

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Fire").volume_db = global.sounds_v


func _input(_event):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var pcman = get_node(".")
	var rtcat = RTCat.instance()
	var collision
	
	
	if p_var.state == 4:
		get_node("PCMan_Node").animation = "Die"
		get_node("Walking").visible = false
		get_node("Land").visible = false
		get_node("Collision").disabled = true
		get_node("Hurtbox/CollisionShape2D").disabled = true
		global.mute = true
		if get_node("PCMan_Node").frame >= 20:
			global.reset()
	if p_var.state == 3:
		if(velocity.y <= 600):
			velocity.y += GRAVITY
		if(velocity.y > 600):
			velocity.y = 600
		# warning-ignore:return_value_discarded
		move_and_slide(velocity, JUMP)
		
		get_node("PCMan_Node").animation = "Hurt"
		#get_node("Collision").one_way_collision = true
		#get_node("Hurtbox/CollisionShape2D").disabled = true
		if get_node("Timer").get_time_left() >= 0.3:
			move_and_collide(Vector2((-direction * p_var.speed * 2),0))
		if start_timer == true:
			get_node("Timer").start()
			start_timer = false
	if p_var.state == 2 or p_var.state == 1:
	
			if(velocity.y <= 600):
				velocity.y += GRAVITY
			if(velocity.y > 600):
				velocity.y = 600
			# warning-ignore:return_value_discarded
			move_and_slide(velocity, JUMP)
	
	
			if get_node("Safe").get_time_left() >= 0.1 and get_node("Safe").get_time_left() <= 1.5:
				get_node("PCMan_Node").visible = true
			
			
			if Input.is_key_pressed(KEY_RIGHT):
				direction = 1
				pcman.get_node("PCMan_Node").flip_h = false
				# warning-ignore:return_value_discarded
				move_and_collide(Vector2(p_var.speed,0))
				if(is_on_floor()):
					pcman.get_node("PCMan_Node").animation = "Walk"
					pcman.get_node("Walking").emitting = true
					pcman.get_node("Walking").visible = true
					pcman.get_node("Walking").rotation_degrees = 0
					pcman.get_node("Walking").position.x = -30
	
			if Input.is_key_pressed(KEY_LEFT):
				direction = -1
				pcman.get_node("PCMan_Node").flip_h = true
		# warning-ignore:return_value_discarded
				move_and_collide(Vector2(-p_var.speed,0))
				if(is_on_floor()):
					pcman.get_node("PCMan_Node").animation = "Walk"
					pcman.get_node("Walking").emitting= true
					pcman.get_node("Walking").visible = true
					pcman.get_node("Walking").rotation_degrees = 180
					pcman.get_node("Walking").position.x = 30
	
			if Input.is_action_just_pressed("ui_accept"):
				if p_var.shots_left > 0:
					p_var.shots_left = p_var.shots_left - 1
					owner.add_child(rtcat)
					rtcat.position = Vector2(direction * 30 + position.x, position.y)
					rtcat.direction = direction
					if direction == -1:
						rtcat.get_node("Sprite").flip_h = true
					pcman.get_node("PCMan_Node").animation = "Shoot"
					get_node("Fire").play()
	
			if(is_on_floor()):
				if !Input.is_key_pressed(KEY_LEFT) and !Input.is_key_pressed(KEY_RIGHT):
					pcman.get_node("Walking").emitting = false
				if land_var == 1:
					pcman.get_node("Land").emitting = true
					land_var = 0
				velocity.y = 200
				if Input.is_key_pressed(KEY_UP):
					if (velocity.y == 200 and jump == 1):
						velocity.y -= p_var.jump_height
						jump = 0
				if(!Input.is_key_pressed(KEY_RIGHT)):
					if(!Input.is_key_pressed(KEY_LEFT)):
						if(!Input.is_key_pressed(KEY_UP)):
							if !Input.is_action_pressed("ui_accept"):
								pcman.get_node("PCMan_Node").animation = "Idle"
			else:
				jump = 1
				pcman.get_node("Land").emitting = false
				pcman.get_node("PCMan_Node").animation = "Jump"
				land_var = 1
				pcman.get_node("Walking").emitting = false
				if is_on_ceiling():
					velocity.y = 0
	#print(p_var.health)
	#print(p_var.state)


func _on_Timer_timeout():
	p_var.state = 2
	get_node("Safe").start()
	get_node("PCMan_Node").visible = false


func _on_Safe_timeout():
	p_var.state = 1
	start_timer = true
	p_var.vulnerable = true
	#get_node("Collision").one_way_collision = false
	#get_node("Hurtbox/CollisionShape2D").disabled = false


func _on_Hurtbox_body_entered(body):
	if p_var.vulnerable == true:
		#if "monster" in body.name:
		#	p_var.health = p_var.health - 1
		#	if p_var.health <= 0:
		#		p_var.state = 4
		#	else:
		#		p_var.state = 3
		#		vulnerable = false
		if body.is_in_group("monster"):
			p_var.health = p_var.health - 1
			p_var.vulnerable = false
			if p_var.health <= 0:
				p_var.state = 4
			else:
				p_var.state = 3
