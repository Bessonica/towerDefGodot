extends Node3D

@onready var player = $Player

# do it onready
@export_group("managers")
@export var economyManager: Node3D
@export var buildManager: Node3D
@export var spawnController: Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass
	#get_tree().call_group("enemiesInside", "updateTargetLocation", player.global_transform.origin)
