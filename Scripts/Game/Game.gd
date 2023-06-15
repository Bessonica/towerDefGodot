extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#	Events.connect("PhaseEnded", changePhase)
#	Events.emit_signal("turnOnPauseMenu")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("Menu"):
		togglePause()



func togglePause():
	var currentPausedValue = get_tree().paused
	if currentPausedValue == true:
		resumeGame()
	else:
		pauseGame()

	
func pauseGame():
	Events.emit_signal("turnOnPauseMenu")
	get_tree().paused = true

func resumeGame():
	Events.emit_signal("turnOffPauseMenu")
	get_tree().paused = false
	
