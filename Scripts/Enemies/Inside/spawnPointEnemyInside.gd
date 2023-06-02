extends Area3D

class_name spawnPointEnemyInside

@export var health:float
@onready var timeLeftLabel = $timeLeft
@onready var timeLeftTimer = $timeLeftTimer
@onready var enemySceneToSpawn = preload("res://Scenes/Enemies/Inside/enemyInside.tscn")
@onready var healthLabel = $HealthLabel

enum spawnPointState{
	activated,
	deactivated
	
}
var currentSpawnPointState
var startOnce: bool
var startHealth: float

# Called when the node enters the scene tree for the first time.
func _ready():
	startHealth = health
	setHealth(health)
	currentSpawnPointState = spawnPointState.deactivated



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeLeftLabel.text = var_to_str(timeLeftTimer.time_left)
	healthLabel.text = var_to_str(health)
	if health <= 0 && currentSpawnPointState == spawnPointState.activated:
		deactivateSpawn()
		#emit signal enemy got burned
	

func startSpawning():
	startCountDown()


func startCountDown():
	timeLeftTimer.start()
	currentSpawnPointState = spawnPointState.activated

func stopCountdown():
	timeLeftTimer.stop()

# one time process
func spawnEnemyInside():
	var enemyToSpawn = enemySceneToSpawn.instantiate()
	add_child(enemyToSpawn)
	
func deactivateSpawn():
	stopCountdown()
	currentSpawnPointState = spawnPointState.deactivated
	health = startHealth
	
func setHealth(amount):
	health = amount
func decreaseHealth(amount):
	if currentSpawnPointState == spawnPointState.activated:
		health -= amount

func _on_time_left_timer_timeout():
	deactivateSpawn()
	spawnEnemyInside()

