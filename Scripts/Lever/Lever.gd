extends Area3D

@export var economyManager: Node3D
@export var gameStatsManager: Node3D
var firstPull: bool
var generatorState
# Called when the node enters the scene tree for the first time.
func _ready():
	firstPull = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func toggleGenerator():
	if firstPull:
		gameStatsManager.changePhase()
		firstPull = false
	
	generatorState = economyManager.returnCurrentGeneratorState()
	if generatorState == economyManager.generatorState.generatorIsOff:
		economyManager.generatorTurnedOn()
	elif generatorState == economyManager.generatorState.generatorIsOn:
		economyManager.generatorTurnedOff()

func _on_interactable_interacted(interactor):
	toggleGenerator()

