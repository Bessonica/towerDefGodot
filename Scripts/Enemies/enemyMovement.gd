extends CharacterBody3D

#	maybe its better to have sepparate Movement object in world Scene?
#@export var path: Path3D

#@export var movementSpeed := 2
signal enemyLostAllHP
signal enemyLostSomeHP(amount)

signal sendSignalToSetHealth
signal sendSignalToSetSpeed

signal enemyDugDown

@onready var enemyHealthComponent = $Health
@onready var diggingTimer = $DiggingTimer


enum moveState{
	moving,
	stop
}

var startedShaking: bool

var enemyCurrentState
# Called when the node enters the scene tree for the first time.
func _ready():
	startedShaking = false
	enemyCurrentState = moveState.moving # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if startedShaking:
		shake()


func setHealth(amount):
	enemyHealthComponent.setHealth(amount)

#			TODO this function shouldnt be here, but in theory if it was in Enemy status it wouldnt delete Enemy node
func killItself():
	get_parent().killEnemy()
	#queue_free()

func enemyGotKilled():
	killItself()
	Events.emit_signal("enemyKilled")

func startDigging():
	diggingTimer.start()
	startShake()
	
func startShake():
	startedShaking = true

func shake():
	var x = randf_range(0.2, 0.4)
	var z = randf_range(0.2, 0.4)
	position = Vector3(x, 0, z)


func enemyLostSomeHealth(amount):
	enemyLostSomeHP.emit(amount)

func _on_health_enemy_lost_all_hp():
	enemyGotKilled()

#func killItself():
#	enemyLostAllHP.emit()

func _on_digging_timer_timeout():
	enemyDugDown.emit()
	Events.emit_signal("enemyDugDown")
	killItself()

