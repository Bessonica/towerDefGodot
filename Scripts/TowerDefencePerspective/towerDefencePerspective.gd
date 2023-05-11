extends Node3D


@onready var Camera = $Camera3D
@onready var RayCast = $RayCast3D

@export var buildManager: Node3D

enum tdPerspectiveState{
	currentPerspective,
	notCurrentPerspective
}

var currentState

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	match currentState:
		tdPerspectiveState.currentPerspective:
			if event is InputEventMouseButton and event.pressed and event.button_index == 1:
				updateRayCast()
				

func _physics_process(delta):
	match currentState:
		tdPerspectiveState.currentPerspective:
			if RayCast.is_colliding():
				var buildPlatform = RayCast.get_collider() as build_platform
				buildManager.buildBuilding(buildPlatform)
				print("INTERCEPTED BUILD OBJECT")
				putRayCastToDefault()
			
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match currentState:
		tdPerspectiveState.currentPerspective:
			pass

func updateRayCast():
	var to = Camera.project_ray_normal(get_viewport().get_mouse_position()) * 10
	print("to = ", to)
	RayCast.target_position = to

func putRayCastToDefault():
	RayCast.target_position = Vector3(1, 0, 0)

func returnCamera():
	return Camera

func setUpPerspective():
	Camera.make_current()
	currentState = tdPerspectiveState.currentPerspective

func perspectiveLeft():
	currentState = tdPerspectiveState.notCurrentPerspective
	
#	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
