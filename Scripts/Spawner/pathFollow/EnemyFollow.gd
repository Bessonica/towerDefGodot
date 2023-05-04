extends PathFollow3D

@onready var enemyChild = get_node("Enemy")


@export var movementSpeed: float
@export var health: int
@onready var enemyState = enemyChild.enemyCurrentState

var progressRatio = 0

func _init():
	set_h_offset(randf_range(-0.5, 0.5))
	if enemyChild == null:
		pass
		#print("enemy is null")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	progressRatio = get_progress_ratio()
	if (progressRatio >= 1):
		killEnemy()

	match enemyState:
		enemyChild.moveState.moving:
			progress += movementSpeed * delta
		enemyChild.moveState.stop:
			pass
	
func killEnemy():
	enemyChild.enemyGotKilled()
	queue_free()
	
	
func setSpeed(amount):
	movementSpeed = amount
	
func setHealth(amount):
	health = amount
	

