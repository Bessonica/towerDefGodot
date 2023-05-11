extends Area3D

class_name build_platform

#@export var turretList: Array[Area3D]
#@export var turretToBuild: PackedScene

var turretReference: Node3D

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

func returnOwnID():
	pass

#instantiate turret itself
func buildTurret(turretToBuild, turretResource):
	var turretToInstantiate = turretToBuild.instantiate()
	turretToInstantiate.setDamage(turretResource.damage)
	turretToInstantiate.setReload(turretResource.reloadTime)
	
	add_child(turretToInstantiate)
	currentState = buildPlatformState.hasBuilding


	


# platform  take off turret from there
func removeTurret():
	print("turret Removed")
	for child in get_children():
		if child.is_in_group("turret"):
			child.destroyItself()
			
	currentState = buildPlatformState.canBuild
	
# delete turret itself
func deleteTurret():
	pass
	
