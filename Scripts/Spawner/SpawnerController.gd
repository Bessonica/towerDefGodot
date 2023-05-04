extends Node3D

@export var waveArray: Resource

var doItOnce: bool

var enemyPath
#signal startingWave(enemyPath, waveResource)

var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _init():
	doItOnce = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if doItOnce:
		startWave(0, waveArray.waveArray[0])
		doItOnce = false


func startWave(enemyPathIndex, waveResource):
	enemyPath = get_child(enemyPathIndex)
	#enemyPath.currentSpawnState = enemyPath.spawnState.startSpawn
	enemyPath.startSpawning(waveResource)
	
func startWaveAfterSec(amount, enemyPathIndex, waveResource):
	await get_tree().create_timer(amount).timeout
	startWave(enemyPathIndex, waveResource)

func stopWave(enemyPathIndex):
	enemyPath = get_child(enemyPathIndex)
	enemyPath.currentSpawnState = enemyPath.spawnState.stopSpawn
	
func stopAllPath():
	for i in get_child_count():
		stopWave(i)


