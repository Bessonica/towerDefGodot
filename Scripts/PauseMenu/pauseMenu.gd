extends Control

var latestMouseMode = 2
@export var gameObject: Node3D
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


func _on_resume_button_pressed():
	gameObject.resumeGameAndMenu()



func _on_exit_button_pressed():
	gameObject.exitGame()



func _on_reload_button_pressed():
	gameObject.reloadGame()

