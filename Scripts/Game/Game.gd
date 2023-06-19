extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("playerGotKilled", playerGotKilled)
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
		resumeGameAndMenu()
	else:
		pauseGameAndMenu()

func pauseGameAndMenu():
	Events.emit_signal("turnOnPauseMenu")
	get_tree().paused = true

func resumeGameAndMenu():
	Events.emit_signal("turnOffPauseMenu")
	get_tree().paused = false
	
func pauseGame():
	get_tree().paused = true
func resumeGame():
	get_tree().paused = false
	
func exitGame():
	get_tree().quit()

func playerGotKilled():
	pauseGame()

func reloadGame():
	var _reload = get_tree().reload_current_scene()
	#get_tree().reload_current_scene()

