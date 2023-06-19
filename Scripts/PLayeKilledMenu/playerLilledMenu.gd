extends Control

@export var gameObject: Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	Events.connect("playerGotKilled", playerGotKilled)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func playerGotKilled():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	show()


func _on_exit_button_pressed():
	gameObject.exitGame()



func _on_restart_button_pressed():
	gameObject.reloadGame()
