extends Control

var latestMouseMode
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	Events.connect("turnOnPauseMenu", turnOnPauseMenu)
	Events.connect("turnOffPauseMenu", turnOffPauseMenu)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func turnOnPauseMenu():
	show()
	latestMouseMode = Input.get_mouse_mode()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func turnOffPauseMenu():
	Input.set_mouse_mode(latestMouseMode)
	hide()
