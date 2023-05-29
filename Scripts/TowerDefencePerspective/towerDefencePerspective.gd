extends Node3D

@onready var TurretLimitText = $CanvasLayer/UI/CurrentAmount
@onready var TurretLimitProgressBar = $CanvasLayer/UI/ProgressBarGenerator
@onready var towerDefenceUI = $CanvasLayer
@onready var bombProgressBar = $CanvasLayer/UI/ProgressBarBomb

@onready var Camera = $Camera3D
@onready var RayCast = $RayCast3D

@onready var uiElement = $CanvasLayer/UI

@export_group("managers")
@export var economyManager: Node3D
@export var buildManager: Node3D
@export var abilityManager: Node3D

enum tdPerspectiveState{
	currentPerspective,
	notCurrentPerspective
}

enum mouseState{
	isBuilding,
	usingAbility,
	empty
}

var currentState
var currentMouseState
var mouseIndex = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	currentMouseState = mouseState.empty


func _input(event):
	match currentState:
		tdPerspectiveState.currentPerspective:
			if event is InputEventMouseButton and event.pressed and event.button_index == 1:
				updateRayCast()
				

func _physics_process(delta):
	match currentState:
		tdPerspectiveState.currentPerspective:
			if (RayCast.is_colliding() && currentMouseState == mouseState.isBuilding):
				var buildPlatform = RayCast.get_collider() as build_platform
				if buildPlatform is build_platform:	
					buildManager.buildBuilding(buildPlatform, mouseIndex)
					
				putRayCastToDefault()
				currentMouseState = mouseState.empty
				uiElement.clearAllColor()
			elif (RayCast.is_colliding() && currentMouseState == mouseState.usingAbility):
				var collisionPosition = RayCast.get_collision_point()
				abilityManager.useAbility(collisionPosition, mouseIndex)
				
				putRayCastToDefault()
				currentMouseState = mouseState.empty
				uiElement.clearAllColor()
			elif (RayCast.is_colliding() && currentMouseState == mouseState.empty):
				var buildPlatform = RayCast.get_collider() as build_platform
				if buildPlatform is build_platform:	
					buildManager.removeBuilding(buildPlatform)
					
				putRayCastToDefault()
				currentMouseState = mouseState.empty
				uiElement.clearAllColor()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	TurretLimitProgressBar.value = economyManager.getTimerPercentage()
	bombProgressBar.value = abilityManager.getTimerPercentage()
	match currentState:
		tdPerspectiveState.currentPerspective:
			pass

func updateRayCast():
	var to = Camera.project_ray_normal(get_viewport().get_mouse_position()) * 10
	#print("to = ", to)
	RayCast.target_position = to

func putRayCastToDefault():
	RayCast.target_position = Vector3(1, 0, 0)

func returnCamera():
	return Camera

func setUpPerspective():
	Camera.make_current()
	towerDefenceUI.visible = true
	currentState = tdPerspectiveState.currentPerspective

func perspectiveLeft():
	currentState = tdPerspectiveState.notCurrentPerspective
	towerDefenceUI.visible = false
	
#	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func updateTextUI(newValue):
	TurretLimitText.text = str(newValue) 

func _on_economy_manager_turret_current_amount_is_changed(newValue):
	updateTextUI(newValue)



func _on_turret_one_pressed():
	print("BUTTON PRESSED")
	currentMouseState = mouseState.isBuilding
	mouseIndex = 0
	uiElement.changeColor(0)

func _on_turret_two_pressed():
	currentMouseState = mouseState.isBuilding
	mouseIndex = 1
	uiElement.changeColor(1)

func _on_clear_pressed():
	currentMouseState = mouseState.usingAbility
	mouseIndex = 11
	uiElement.changeColor(2)

