extends Area3D


var enemiesAround

var readyToShoot: bool

@onready var rayCast = $RayCast3D

@export var player: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#

# Called every frame. 'delta' is the elapsed time since the previous frame.
"""
func _process(delta):
	enemiesAround = lookForEnemies()
	if enemiesAround.size() != 0:
		print("__enemies around: __", enemiesAround.size())
		lookAtEnemy(enemiesAround[0])
"""


func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	#rayCast.look_at(player.global_position)
	
	enemiesAround = lookForEnemies()
	if enemiesAround.size() != 0:
		lookAtEnemy(enemiesAround[0])
	else:
		rayCast.target_position = Vector3(0, 0, 0.8)

func lookForEnemies():
	#	получаем characterBodies3D
	var list: Array[Node3D] = get_overlapping_bodies()
	return list
#	var list: Array[Area3D] = get_overlapping_areas()

func lookAtEnemy(enemy):
	print("enemy position: ", enemy.global_position)
	var relitivePosition = enemy.global_position - rayCast.global_position
	rayCast.target_position = relitivePosition

	#rayCast.look_at(enemy.position)
	# global_transform    and   .global_position
	#		what is the difference.   read about transform
	




func changeTurretRadius(amount):
	pass

#	bool readyToFire to check in process can you shoot or not
func fire():
	pass
	
	
	
	
	
	
