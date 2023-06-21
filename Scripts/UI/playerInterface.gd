extends Control

var cursorDefault = load("res://Textures/UI/playerUI/defaultCursor.png")
var cursorFocused = load("res://Textures/UI/playerUI/activatedCursor.png")
@onready var centerCursor = $CenterCursor


func _ready():
	centerCursor.texture = cursorDefault

func changeCenterTextureToFocused():
	centerCursor.texture = cursorFocused
func changeCenterTextureToDefault():
	centerCursor.texture = cursorDefault
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
