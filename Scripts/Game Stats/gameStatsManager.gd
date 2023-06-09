extends Node3D

# counts how many enemies reached the end, and how many waves ended

#	TODO ask on forums
#var waveSpawnsFinished: int: set = waveSpawnsFinishedSet, get = waveSpawnsFinishedChanged

@export var spawnController: Node3D

var phases = [0, 1, 2]
var currentPhase = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	#enemyScene.enemyDugDown.connect(printInfo)
	Events.connect("enemyDugDown", printInfo)
	Events.connect("PhaseEnded", changePhase)
	await get_tree().create_timer(4).timeout
	#changePhase()
	#spawningEnded

func changePhase():
	match currentPhase:
		0:
			startPhaseOne()
			#currentPhase += 1
		1:
			Events.emit_signal("phaseOneEnded")
			startPhaseTwo()
			#currentPhase += 1
		2:
			Events.emit_signal("phaseTwoEnded")
			startPhaseThree()
			print("PHASE TWO ENDED")
		3:
			Events.emit_signal("phaseThreeEnded")
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func printInfo():
	pass
	#print("enemy dug down")


func startPhaseOne():
	Events.emit_signal("phaseOneStarted")
	spawnController.phaseOne() 
	currentPhase = 1

func phaseOneEnded():
	print("world.gd phase ONE ENDED")

func startPhaseTwo():
	Events.emit_signal("phaseTwoStarted")
	spawnController.phaseTwo() 
	currentPhase = 2

func startPhaseThree():
	Events.emit_signal("phaseThreeStarted")
	spawnController.phaseThree() 
	currentPhase = 3
