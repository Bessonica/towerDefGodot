extends Node3D

# counts how many enemies reached the end, and how many waves ended

#	TODO ask on forums
#var waveSpawnsFinished: int: set = waveSpawnsFinishedSet, get = waveSpawnsFinishedChanged
var waveSpawnsFinished: int: set = setWaveSpawnsFinished, get = getWaveSpawnsFinished

# Called when the node enters the scene tree for the first time.
func _ready():
	#enemyScene.enemyDugDown.connect(printInfo)
	waveSpawnsFinished = 0
	Events.connect("enemyDugDown", printInfo)
	Events.connect("waveSpawningEnded", countWaveSpawns)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func printInfo():
	pass
	#print("enemy dug down")

func countWaveSpawns():
	waveSpawnsFinished += 1
	print("(gameStats.gd) waveSpawns = ", waveSpawnsFinished)

func reloadWaveSpawns():
	waveSpawnsFinished = 0


func setWaveSpawnsFinished(newValue):
	waveSpawnsFinished = newValue
	Events.emit_signal("variableWaveSpawnsFinishedChanged", newValue)
func getWaveSpawnsFinished():
	return waveSpawnsFinished

"""
#	TODO ask on forums
func waveSpawnsFinishedChanged(newValue):
	waveSpawnsFinished = newValue
func waveSpawnsFinishedSet():
	return waveSpawnsFinished
"""
