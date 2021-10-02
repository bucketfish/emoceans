extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var frontwave = $front
onready var backwave = $back

# Called when the node enters the scene tree for the first time.
func _ready():
	frontwave.playing = true
	backwave.playing = true
	$w1/front.playing = true
	$w1/back.playing = true
	$w2/front.playing = true
	$w2/back.playing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
