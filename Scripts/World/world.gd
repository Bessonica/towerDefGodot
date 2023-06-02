extends Node3D

@onready var player = $Player

# do it onready
#@export_group("managers")
@onready var spawnController = $SpawnerController
@onready var buildManager = $BuildManager
@onready var economyManager = $economyManager
@onready var gameStatsManager = $GameStatsManager

@export_group("phases")
@export_subgroup("phaseOne")
@export var amountOfWavesOne: int
@export_subgroup("phaseTwo")
@export var amountOfWavesTwo: int
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("variableWaveSpawnsFinishedChanged", printInfo)
	await get_tree().create_timer(6).timeout
	startPhaseOne()

	#Events.connect("waveSpawningEnded", changePhase)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	get_tree().call_group("enemiesInside", "updateTargetLocation", player.global_transform.origin)


func printInfo(newValue):
	print("(world.gd) wave finished, new value = ", newValue)



func changePhase():
	pass

func startPhaseOne():
	spawnController.phaseOne() 


func endPhaseOne():
	#stop wave .. .
	pass
	

func startPhaseTwo():
	pass
