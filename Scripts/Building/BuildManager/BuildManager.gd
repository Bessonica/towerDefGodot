extends Area3D

#	have a children build platform
#	decides can you build there or not(enaugh recources)

# Called when the node enters the scene tree for the first time.

@export var turretToBuild: PackedScene
@export var turretResource: Resource

#	TODO	scene to manage how much money/in game resources player has
@export var economyManager: PackedScene

func _ready():
	await get_tree().create_timer(10).timeout
	turnOffAllBuildings()# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func turnOffAllBuildings():
	for child in get_children():
		child.removeTurret()
		
	


func setBuilding(buildPlatform):
	buildPlatform.setTurret(turretToBuild, turretResource)

func checkIfCanBuild(buildPlatform):
	if buildPlatform.currentState == buildPlatform.buildPlatformState.canBuild:
		return true
	else:
		return false


#	method that tower defence perspective calls
func buildBuilding(buildPlatform):
	var canBuild: bool
	
	canBuild = checkIfCanBuild(buildPlatform)
	if canBuild:
		setBuilding(buildPlatform)
	


#	buildBuilding(buildplatform)
#		checkData -> check if we can actually build (recources)
#			spawnBuilding -> if yes then we build
