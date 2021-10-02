extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer:float = 0

onready var frontwave = $front
onready var backwave = $back

onready var anim = $cutscenes

onready var sail = $sail
onready var info = $info
onready var quit = $quit
onready var title = $title
onready var restart = $restart

export var playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("start")
	anim.play("backtomenu")
	frontwave.playing = true
	backwave.playing = true
	$w1/front.playing = true
	$w1/back.playing = true
	$w2/front.playing = true
	$w2/back.playing = true
	

func game_over():
	anim.play("endgame")
	$texts.text = "good job! you lived %02d.%03ds in the emoceans." % [timer, fmod(stepify(timer, 0.01), 1) * 1000]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_sail_pressed():
	anim.play("startgame")


func _on_restart_pressed():
	anim.play("backtomenu")


func _on_info_pressed():
	anim.play("info")


func _on_quit_pressed():
	get_tree().quit()
