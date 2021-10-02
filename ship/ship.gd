extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tilt:float = 0
var tiltspeed:float = 0
var tiltacc:float = 1.0
var curtiltacc:float = 1.0

var delay:float = 0
var curdelay:float = 0

var presstilt:float = 5.0
var curpresstilt:float = 5.0
var press_direction = 0

var wavetilt = 10.0

var emotion = Emotions.NEUTRAL

onready var text = get_node("/root/base/RichTextLabel")
onready var w1 = get_node("/root/base/w1")
onready var w2 = get_node("/root/base/w2")
onready var wheel = $wheel

onready var background = get_node("/root/base/CanvasLayer/ColorRect")
onready var base = get_node("/root/base")

var backgroundcolor = "#B8E0D2"
var lerpcolor = "#B8E0D2"

enum Emotions {
	NEUTRAL, HAPPY, SAD, ANGRY
}

var emotion_map = {
	Emotions.NEUTRAL: "neutral",
	Emotions.HAPPY: "happy",
	Emotions.SAD: "sad",
	Emotions.ANGRY: "angry"
}

var numbers = {
	Emotions.NEUTRAL:{
		"tiltacc": 1.0,
		"delay": 0.0,
		"presstilt": 5.0
	},
	Emotions.HAPPY: {
		"tiltacc": 1.0,
		"delay": 0.0,
		"presstilt": 10.0
	},
	Emotions.SAD: {
		"tiltacc": 0.3,
		"delay": 3.0,
		"presstilt": 2.0
	},
	Emotions.ANGRY: {
		"tiltacc": 3.0,
		"delay": 0.0,
		"presstilt": 10.0
	}
}

var colors = {
	Emotions.NEUTRAL: "#9CCFFB",
	Emotions.HAPPY: "#D6EADF",
	Emotions.ANGRY: "#FF7070",
	Emotions.SAD: "#465872"
}

onready var emotion_images = {
	Emotions.NEUTRAL: get_node("/root/base/emotions_0002"),
	Emotions.HAPPY: get_node("/root/base/emotions_0003"),
	Emotions.ANGRY: get_node("/root/base/emotions_0000"),
	Emotions.SAD: get_node("/root/base/emotions_0001")
}

var playing = true
var t:float = 0
var t2:float = 0
var waves = 0
var additional:float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	background.modulate = backgroundcolor
	randomize()
	change_mood()
	change_waves()

func startgame():
	t = 0
	t2 = 0
	tilt = 0
	tiltspeed = 0
	
func change_mood():
	if tilt < 50 && tilt > -50:
		t = rand_range(5,8)
		emotion = randi()%4
		for i in numbers[emotion].keys():
			set(i, numbers[emotion][i])
		backgroundcolor = colors[emotion]
		$Tween.interpolate_property(background,"color",background.color,Color(backgroundcolor), 1, Tween.TRANS_LINEAR)
		$Tween.start()
		
		if base.playing:
			for i in emotion_images.keys():
				emotion_images[i].visible = false
			emotion_images[emotion].visible = true
			
	else:
		t = rand_range(2,4)

func change_waves():
	t2 = rand_range(5, 8)
	
	var rand = randi()%5
	w1.visible = false
	w2.visible = false
	if rand == 0:
		waves = -1
		w1.visible = true
	elif rand == 4:
		waves = 1
		w2.visible = true
	else:
		waves = 0
		
	

func _physics_process(delta):
	if !base.playing:
		return
		
	base.timer += delta
	
	t -= delta
	t2 -= delta
	
	if t <= 0:
		change_mood()
	if t2 <= 0:
		change_waves()
	
	if Input.is_action_just_pressed("debug"):
		change_mood()
		playing = false
		
	var curphy = emotion
	curdelay = lerp(curdelay, delay, 0.2)
	curtiltacc = lerp(curtiltacc, tiltacc, 0.2)
	curpresstilt = lerp(curpresstilt, presstilt, 0.2)

	

	
	text.text = str(emotion_map[emotion])
	get_input()
	if curphy != emotion:
		return

	
	
	tiltspeed += curpresstilt * press_direction
	
	if tilt > waves * wavetilt:
		tiltspeed += curtiltacc
	elif tilt < waves * wavetilt:
		tiltspeed -= curtiltacc
	
	if tilt >= 90 || tilt <= -90:
		game_over()
	
	tilt += tiltspeed * delta
	
	rotation_degrees = tilt
	wheel.rotation_degrees = tilt * 3
	
	
func get_input():
	yield(get_tree().create_timer(curdelay), "timeout")
	press_direction = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))

func game_over():
	base.game_over()
