extends Area3D

#	have a children build platform
#	decides can you build there or not(enaugh recources)

@export_group("turrets")
@export_subgroup("simple turret, (index 0)")
@export var turretToBuildFirst: PackedScene
@export var turretResourceFirst: Resource

@export_subgroup("second turret, (index 1)")
@export var turretToBuildSecond: PackedScene
@export var turretResourceSecond: Resource

@onready var turretArray = [[turretToBuildFirst, turretResourceFirst], [turretToBuildSecond, turretResourceSecond]]
var turretToBuild: PackedScene
var turretResourceToBuild: Resource

#	TODO	scene to manage how much money/in game resources player has
@export_group("economy Manager")
@export var economyManager: Area3D



func _ready():
	pass
	#await get_tree().create_timer(8).timeout
	#turnOffAllBuildings()# Replace with function body.


func _process(delta):
	pass

func turnOffAllBuildings():
	for child in get_children():
		child.removeTurret()

func setBuilding(buildPlatform, buildingIndex):
	if buildingIndex<=(turretArray.size() - 1):
		turretToBuild = turretArray[buildingIndex][0]
		turretResourceToBuild = turretArray[buildingIndex][1]
		buildPlatform.setTurret(turretToBuild, turretResourceToBuild)
	else:
		print("building index is to large = ")
		print("turret array size = ", turretArray.size())
		print("buildingIndex = ", buildingIndex)

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
func buildBuilding(buildPlatform, buildingIndex):
	var canBuild: bool
	
	canBuild = checkIfCanBuild(buildPlatform)
	if canBuild:
		setBuilding(buildPlatform, buildingIndex)
		
func removeBuilding(buildPlatform):
	buildPlatform.removeTurret()

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
