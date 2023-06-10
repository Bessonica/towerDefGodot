extends Area3D

class_name turret

var enemiesAround

var readyToShoot: bool

@onready var rayCast = $RayCast3D

#@export var player: Node3D

@onready var coolDownTimer = $ReloadTimer
@onready var collisionShape = $CollisionShape3D

@export var damage: float
@export var reloadTime: float


enum turretState{
	shooting,
	reload,
	readyToShoot,
	overHeated
}

var currentTurretState

# Called when the node enters the scene tree for the first time.
func _ready():
	currentTurretState = turretState.readyToShoot
	coolDownTimer.start()
	# Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
"""
func _process(delta):
	enemiesAround = lookForEnemies()
	if enemiesAround.size() != 0:
		print("__enemies around: __", enemiesAround.size())
		lookAtEnemy(enemiesAround[0])
"""


func _physics_process(delta):
	enemiesAround = lookForEnemies()
	
	match currentTurretState:
		turretState.readyToShoot:
			rayCast.debug_shape_custom_color = Color("3a4eb5")

			if enemiesAround.size() != 0:
				shootEnemy(enemiesAround[0])
				reload(reloadTime)
			else:
				rayCast.target_position = Vector3(0, 0, 0.8)
			
		turretState.reload:
			rayCast.debug_shape_custom_color = Color("d39500")
			#	d39500
			pass
	


func lookForEnemies():
	#	получаем characterBodies3D
	var list: Array[Node3D] = get_overlapping_bodies()
	return list
#	var list: Array[Area3D] = get_overlapping_areas()

func lookAtEnemy(enemy):
	#print("enemy position: ", enemy.global_position)
	var relitivePosition = enemy.global_position - rayCast.global_position
	rayCast.target_position = relitivePosition

func shootEnemy(enemy):
	lookAtEnemy(enemy)
	enemy.enemyLostSomeHealth(damage)
	
func reload(time):
	currentTurretState = turretState.reload
	# coolDownTimer
	await get_tree().create_timer(reloadTime).timeout
	currentTurretState = turretState.readyToShoot
	
	
	#rayCast.look_at(enemy.position)
	# global_transform    and   .global_position
	#		what is the difference.   read about transform
	"""
	if enemiesAround.size() != 0:
		lookAtEnemy(enemiesAround[0])
		enemiesAround[0].enemyLostSomeHealth(damage)
	else:
		rayCast.target_position = Vector3(0, 0, 0.8)
	"""


func changeTurretRadius(amount: float):
	pass
	#collisionShape.radius = amount 

	
func destroyItself():
	queue_free()
	
	
func setDamage(amount):
	damage = amount
	
func setReload(amount):
	reloadTime = amount


func _on_reload_timer_timeout():
	changeTurretRadius(2.0) # Replace with function body.
