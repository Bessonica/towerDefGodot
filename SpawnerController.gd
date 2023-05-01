extends Node3D

@export var waveArray: Resource


var enemyPath
#signal startingWave(enemyPath, waveResource)

var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	timer = timer + delta
	if(timer>= 20):
		stopAllPath()
		timer = 0


func startWave(enemyPathIndex, waveResource):
	enemyPath = get_child(enemyPathIndex)
	enemyPath.currentSpawnState = enemyPath.spawnState.startSpawn
	
func stopWave(enemyPathIndex):
	enemyPath = get_child(enemyPathIndex)
	enemyPath.currentSpawnState = enemyPath.spawnState.stopSpawn
	
func stopAllPath():
	for i in get_child_count():
		stopWave(i)


