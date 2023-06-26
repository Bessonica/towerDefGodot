extends PathFollow3D

@onready var enemyChild = get_node("Enemy")


@export var movementSpeed: float
@export var health: int
@onready var enemyState = enemyChild.enemyCurrentState


var enemyTypeFat: bool

var progressRatio = 0
var stopPoint = randf_range(0.8, 1)

var reachedEndBool = false

func _init():
	set_h_offset(randf_range(-0.5, 0.5))
	if enemyChild == null:
		pass
		#print("enemy is null")


# Called when the node enters the scene tree for the first time.
#		cant setUp health in function setHealth. says that enemychild is nil
func _ready():
	enemyChild.setHealth(health)
	enemyChild.setType(enemyTypeFat) 

func _process(delta):
	progressRatio = get_progress_ratio()
	if (progressRatio >= stopPoint):
		if enemyTypeFat:
			Events.emit_signal("fatEnemyMovedWholeWay")
		enemyState = enemyChild.moveState.stop
		reachedEnd()
	if(progressRatio >= 0.5):
		Events.emit_signal("fatEnemyMovedHalfWay")
	
	match enemyState:
		enemyChild.moveState.moving:
			progress += movementSpeed * delta
		enemyChild.moveState.stop:
			pass
	
func killEnemy():
	enemyChild.queue_free()
	queue_free()

func reachedEnd():
	if reachedEndBool == false:
		enemyChild.startDigging()
		reachedEndBool = true
	
func setSpeed(amount):
	movementSpeed = amount

func setHealth(amount):
	health = amount
	
func setType(boolValue):
	enemyTypeFat = boolValue
