extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = 0
onready var global = get_node("/root/Global")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Back").visible = false
	get_node("Keyboard").visible = false
	get_node("Space_controls").visible = false
	get_node("Jump_controls").visible = false
	get_node("Move_controls").visible = false
	get_node("Talk_controls").visible = false
	get_node("Credits_text").visible = false
	get_node("Volume_m").value = global.temp_m + 50
	get_node("Volume_s").value = global.sounds_v + 50
	if global.mute == true:
		global.mute = false
	get_node("HighScore_Value").text = str(global.highscore)

func _on_Start_pressed():
	
	get_tree().change_scene("res://GameScene1.tscn")


func _on_Back_pressed():
	if state == 0 :
		get_node("Keyboard").visible = false
		get_node("Space_controls").visible = false
		get_node("Jump_controls").visible = false
		get_node("Move_controls").visible = false
		get_node("Talk_controls").visible = false
	else :
		get_node("Credits_text").visible = false
	get_node("Start").visible = true
	get_node("Controls").visible = true
	get_node("Credits").visible = true
	get_node("Volume_m").visible = true
	get_node("Volume_s").visible = true
	get_node("Volume_text").visible = true
	get_node("Back").visible = false


func _on_Controls_pressed():
	state = 0
	get_node("Start").visible = false
	get_node("Controls").visible = false
	get_node("Credits").visible = false
	get_node("Volume_m").visible = false
	get_node("Volume_s").visible = false
	get_node("Volume_text").visible = false
	get_node("Back").visible = true
	get_node("Keyboard").visible = true
	get_node("Space_controls").visible = true
	get_node("Jump_controls").visible = true
	get_node("Move_controls").visible = true
	get_node("Talk_controls").visible = true


func _on_Credits_pressed():
	state = 1
	get_node("Start").visible = false
	get_node("Controls").visible = false
	get_node("Credits").visible = false
	get_node("Volume_m").visible = false
	get_node("Volume_s").visible = false
	get_node("Volume_text").visible = false
	get_node("Back").visible = true
	get_node("Credits_text").visible = true


func _on_Volume_m_value_changed(value):
	global.music_v = value - 50
	global.temp_m = global.music_v
	get_node("Music").volume_db = global.music_v


func _on_Volume_s_value_changed(value):
	global.sounds_v = value - 50
	get_node("Sound").volume_db = global.sounds_v
	get_node("Sound").play()
