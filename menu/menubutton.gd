extends TextureButton


export var words:String
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var label = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	label.bbcode_text = "[center]" + str(words)
	label.bbcode_enabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_menubutton_focus_entered():
	label.bbcode_text = "[center]•" + str(words) + "•"


func _on_menubutton_focus_exited():
	label.bbcode_text = "[center]" + str(words)
