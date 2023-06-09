extends Node3D

@export var waveArray: Resource

var doItOnce: bool

var enemyPath
#signal startingWave(enemyPath, waveResource)

var timer = 0
var currentWavesToSpawn
var wavesToSpawn

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("waveSpawningEnded", countWaveSpawns)
	currentWavesToSpawn = 0
	wavesToSpawn = 0
	pass
	#await get_tree().create_timer(10).timeout
	#startWaveOnce(0, waveArray.waveArray[1])
	
	
	#await get_tree().create_timer(10).timeout
	#stopWave(0)
	

func _init():
	doItOnce = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func startWaveQueue():
	pass

func startWave(enemyPathIndex, waveResource, newWaveSpawnTime = 0):
	enemyPath = get_child(enemyPathIndex)
	#enemyPath.currentSpawnState = enemyPath.spawnState.startSpawn
	enemyPath.startSpawning(waveResource, newWaveSpawnTime)
	
func startWaveAfterSec(amount, enemyPathIndex, waveResource, newWaveSpawnTime = 0):
	await get_tree().create_timer(amount).timeout
	startWave(enemyPathIndex, waveResource, newWaveSpawnTime)

func stopWave(enemyPathIndex):
	enemyPath = get_child(enemyPathIndex)
	enemyPath.stopSpawn()
	#enemyPath.currentSpawnState = enemyPath.spawnState.stopSpawn

func startWaveOnce(enemyPathIndex, waveResource):
	enemyPath = get_child(enemyPathIndex)
	enemyPath.spawnOnce(waveResource)


func stopAllPath():
	for i in get_child_count():
		stopWave(i)

func phaseOne():
	startWaveAfterSec(3, 2, waveArray.waveArray[0], 5)
	startWaveAfterSec(43, 5, waveArray.waveArray[0], 5)
	#startWave(0, waveArray.waveArray[0], 3)
	#startWave(1, waveArray.waveArray[0], 3)
	#startWaveAfterSec(3, 2, waveArray.waveArray[0], 5)
	wavesToSpawn = 2

func phaseTwo():
	startWaveAfterSec(8, 1, waveArray.waveArray[0], 3)
	startWaveAfterSec(15, 7, waveArray.waveArray[2], 1)
	wavesToSpawn = 2

func phaseThree():
	startWaveAfterSec(8, 8, waveArray.waveArray[0], 2)
	startWaveAfterSec(15, 9, waveArray.waveArray[2], 1)
	startWaveAfterSec(20, 3, waveArray.waveArray[2], 1)
	wavesToSpawn = 3


func countWaveSpawns():
	if currentWavesToSpawn >= 0 && wavesToSpawn > 0:
		currentWavesToSpawn += 1
	if wavesToSpawn <= currentWavesToSpawn:
		Events.emit_signal("PhaseEnded")
		#	PhaseEnded	spawningEnded
		wavesToSpawn = 0
		currentWavesToSpawn = 0


