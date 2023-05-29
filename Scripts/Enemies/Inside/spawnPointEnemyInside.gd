extends Area3D

@export var health:float
@onready var timeLeftLabel = $timeLeft
@onready var timeLeftTimer = $timeLeftTimer
@onready var enemySceneToSpawn = preload("res://Scenes/Enemies/Inside/enemyInside.tscn")

enum spawnPontState{
	activated
	
}
var startOnce: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(3).timeout
	startCountDown()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeLeftLabel.text = var_to_str(timeLeftTimer.time_left)
	if health <= 0:
		deactivateSpawn()
	

func startCountDown():
	timeLeftTimer.start()

# one time process
func spawnEnemyInside():
	var enemyToSpawn = enemySceneToSpawn.instantiate()
	add_child(enemyToSpawn)
	
func deactivateSpawn():
	pass


func _on_time_left_timer_timeout():
	timeLeftTimer.stop()
	spawnEnemyInside()

