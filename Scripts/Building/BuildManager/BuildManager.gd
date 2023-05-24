extends Area3D

#	have a children build platform
#	decides can you build there or not(enaugh recources)

# Called when the node enters the scene tree for the first time.

@export var turretToBuild: PackedScene
@export var turretResource: Resource

#	TODO	scene to manage how much money/in game resources player has
@export var economyManager: Area3D

func _ready():
	pass
	#await get_tree().create_timer(8).timeout
	#turnOffAllBuildings()# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func turnOffAllBuildings():
	for child in get_children():
		child.removeTurret()

func setBuilding(buildPlatform):
	buildPlatform.setTurret(turretToBuild, turretResource)

func checkIfCanBuild(buildPlatform):
	if buildPlatform.currentState == buildPlatform.buildPlatformState.canBuild && economyManager.canPlayerBuild():
		return true
	else:
		print("-")
		print("YOU CANT BUILD")
		print("current limit = ", economyManager.returnCurrentTurretLimitAmount())
		print("limit = ", economyManager.returnTurretLimitAmount())
		print("-")
		return false


#	method that tower defence perspective calls
func buildBuilding(buildPlatform):
	var canBuild: bool
	
	canBuild = checkIfCanBuild(buildPlatform)
	if canBuild:
		setBuilding(buildPlatform)

func returnHowManyTurretsIsOn():
	var turretCount: int
	turretCount = 0
	for child in get_children():
		if child.doesPlatformHasTurret():
			#print("found turret")
			turretCount = turretCount + 1
	return turretCount


#	buildBuilding(buildplatform)
#		checkData -> check if we can actually build (recources)
#			spawnBuilding -> if yes then we build

func turnOffRandomBuilding(amountToTurnOff):
	var childrenPlatform = []
	for child in get_children():
		if child.doesPlatformHasTurret():
			childrenPlatform.append(child)
	for i in range(amountToTurnOff):
		print("hey")
		childrenPlatform[i].removeTurret()
		#	randi_range(0, childrenPlatform.size() - 1)

func _on_economy_manager_timer_is_turned_off():
	turnOffAllBuildings()

func _on_economy_manager_turret_current_amount_is_changed(newValue):
	var turretAmount = returnHowManyTurretsIsOn()
	if turretAmount > newValue:
		turnOffRandomBuilding(turretAmount - newValue)
		print("THERE ARE TO MUCH TURRETS ", (turretAmount - newValue))
