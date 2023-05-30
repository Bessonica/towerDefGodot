extends CharacterBody3D

#	when gets out of walls, runs straight to player really fast.
#		if attacked with flames, slows down significatly and screams.


@export var health = 2
@export var speed = 2.0

@onready var navigationAgent = $NavigationAgent3D
@onready var stopTimer = $StopTimer

enum enemyInsideState{
	moving,
	stopped
}
var currentEnemyInsideState
# Called when the node enters the scene tree for the first time.
func _ready():
	currentEnemyInsideState = enemyInsideState.moving



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		killItself()
	
func _physics_process(delta):
	match currentEnemyInsideState:
		enemyInsideState.moving:
			var currentLocation = global_transform.origin
			var nextLocation = navigationAgent.get_next_path_position()	# or  get_next_path_position()
			var newVelocity = (nextLocation - currentLocation).normalized() * speed
			velocity = newVelocity
			move_and_slide()
		enemyInsideState.stopped:
			pass


func updateTargetLocation(targetLocation):
	navigationAgent.target_position = targetLocation

func killItself():
	queue_free()
#	goal: when enemy in fire it slows gradually, and if player sprays fire for a frame, enemy doesnt stop immediatly
func stopEnemy():
	if currentEnemyInsideState == enemyInsideState.moving:
		currentEnemyInsideState = enemyInsideState.stopped
		stopTimer.start()
func startEnemy():
	if currentEnemyInsideState == enemyInsideState.stopped:
		currentEnemyInsideState = enemyInsideState.moving
		stopTimer.stop()

func decreaseHealth(amount):
	health = health - amount


func _on_stop_timer_timeout():
	startEnemy()

