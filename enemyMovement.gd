extends CharacterBody3D

#	maybe its better to have sepparate Movement object in world Scene?
#@export var path: Path3D

#@export var movementSpeed := 2

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
	
func killItself():
	queue_free()
