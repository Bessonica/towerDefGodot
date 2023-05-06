extends Area3D


@export var turretList: Array[Area3D]
@export var turretToBuild: Area3D

var turretReference: Node3D

enum buildPlatformState{
	empty,
	hasBuilding
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#platform put turret there  +
func setTurret():
	buildTurret()
	

#instantiate turret itself
func buildTurret():
	var turretToInstantiate = turretToBuild.instantiate()
	add_child(turretToInstantiate)

# platform  take off turret from there
func removeTurret():
	pass
	
# delete turret itself
func deleteTurret():
	pass
	
