extends Area3D

class_name build_platform

#@export var turretList: Array[Area3D]
#@export var turretToBuild: PackedScene

var turretReference: Node3D

@onready var cooldownTimer = $CooldownTimer
@onready var mesh = $MeshInstance3D
@onready var cooldwonLabel = $CoolDownLabel3D

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
	if turretToInstantiate is turret:
		turretToInstantiate.setDamage(turretResource.damage)
		turretToInstantiate.setReload(turretResource.reloadTime)
	
	add_child(turretToInstantiate)
	currentState = buildPlatformState.hasBuilding

#	get_material_override()	get_surface_override_material(0)
func setCooldown(amount):
	cooldownTimer.start(amount)
	currentState = buildPlatformState.cannotBuild
	cooldwonLabel.text = "cooldown"
	#var meshMaterial = mesh.mesh.surface_get_material(0)
	#meshMaterial.albedo_color = Color.RED

func stopCooldown():
	currentState = buildPlatformState.canBuild
	cooldownTimer.stop()
	cooldwonLabel.text = ""
	#var meshMaterial = mesh.mesh.surface_get_material(0)
	#meshMaterial.albedo_color = Color.WHITE



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

