extends Path3D


#var follower = preload("res://enemyPathFollow3D.tscn")
var timer = 0
var timeToSpawn = 5


@export var waveArrayResource: Resource

var waveIndex = 0

var gameStartTime = 0

enum spawnState{
	startSpawn,
	stopSpawn
}

var currentSpawnState

# Called when the node enters the scene tree for the first time.
func _ready():
	currentSpawnState = spawnState.stopSpawn
	timer = 0
	gameStartTime = Time.get_ticks_msec()
	print("game started: ", Time.get_ticks_msec())
	
	#timeToSpawn = waveArrayResource.timeToSpawn

#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	match currentSpawnState:
		spawnState.startSpawn:
			timer = timer + delta
			if (timer >= timeToSpawn):
				timer = 0
				print("started to spawn wave: ", waveIndex + 1)
				print("time: ", Time.get_ticks_msec())
				await spawnWave(waveArrayResource.enemyAmount, waveArrayResource.enemyPathFollow)
				waveIndex = waveIndex + 1
				print("finished spawned wave: ", waveIndex)
				
		spawnState.stopSpawn:
			timer = 0
			
	
	
	



# has enemypathfollow object their
func spawnEnemyAndSetUpValues(enemyToSpawn):
	var enemyToAdd = enemyToSpawn.instantiate()
	
	enemyToAdd.setSpeed(waveArrayResource.enemySpeed)
	enemyToAdd.setHealth(waveArrayResource.enemySpeed)
	
	add_child(enemyToAdd)

func spawnWave(amount, enemyToSpawn):
	for x in amount:
		var timerVar = randf_range(0.2, 0.7)
		spawnEnemyAndSetUpValues(enemyToSpawn)
		print("enemy number: ", x)
		await get_tree().create_timer(timerVar, false).timeout
	

func startSpawning(waveResource):
	makeCurrentWave(waveResource)
	currentSpawnState = spawnState.startSpawn

func makeCurrentWave(waveResource):
	waveArrayResource = waveResource
	timeToSpawn = waveResource.timeToSpawn


# get all children and "say" them to change speed
func changeSpeed(newSpeed):
	pass
	
