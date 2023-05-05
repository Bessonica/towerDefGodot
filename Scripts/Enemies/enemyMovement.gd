extends CharacterBody3D

#	maybe its better to have sepparate Movement object in world Scene?
#@export var path: Path3D

#@export var movementSpeed := 2
signal enemyLostAllHP
signal enemyLostSomeHP(amount)

signal sendSignalToSetHealth
signal sendSignalToSetSpeed


@onready var enemyHealthComponent = $Health



enum moveState{
	moving,
	stop
}

var enemyCurrentState
# Called when the node enters the scene tree for the first time.
func _ready():
	enemyCurrentState = moveState.moving # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func setHealth(amount):
	enemyHealthComponent.setHealth(amount)
	
	
#			TODO this function shouldnt be here, but in theory if it was in Enemy status it wouldnt delete Enemy node
func killItself():
	get_parent().killEnemy()
	#queue_free()

func enemyGotKilled():
	killItself()

func enemyLostSomeHealth(amount):
	enemyLostSomeHP.emit(amount)

func _on_health_enemy_lost_all_hp():
	enemyGotKilled()

#func killItself():
#	enemyLostAllHP.emit()


	
