extends Area3D

class_name build_platform

#@export var turretList: Array[Area3D]
#@export var turretToBuild: PackedScene

var turretReference: Node3D

@onready var cooldownTimer = $CooldownTimer

enum buildPlatformState{
	empty,
	canBuild,
	cannotBuild,
	hasBuilding
}

var currentState

# Called when the node enters the scene tree for the first time.
func _ready():
	currentState = buildPlatformState.canBuild



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#	method that build manager calls for
func setTurret(turretToBuild, turretResource):
	buildTurret(turretToBuild, turretResource)

#instantiate turret itself
func buildTurret(turretToBuild, turretResource):
	var turretToInstantiate = turretToBuild.instantiate()
	turretToInstantiate.setDamage(turretResource.damage)
	turretToInstantiate.setReload(turretResource.reloadTime)
	
	add_child(turretToInstantiate)
	currentState = buildPlatformState.hasBuilding


func setCooldown(amount):
	cooldownTimer.start(amount)
	currentState = buildPlatformState.cannotBuild
func stopCooldown():
	currentState = buildPlatformState.canBuild
	cooldownTimer.stop()


# platform  take off turret from there
func removeTurret():
	for child in get_children():
		if child.is_in_group("turret"):
			child.destroyItself()
			currentState = buildPlatformState.canBuild
			print("turret Removed")
			

func doesPlatformHasTurret():
	for child in get_children():
		if child.is_in_group("turret"):
			return true
	#	after the whole cycle we found any turret
	return false

# delete turret itself
func deleteTurret():
	pass

func _on_cooldown_timer_timeout():
	stopCooldown()

