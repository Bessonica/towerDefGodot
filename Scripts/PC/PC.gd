extends Area3D

@export var playerCharacter: Node3D
@onready var towerDefenceView = $TowerDefencePerspective


enum PCState{
	playerIsIn,
	playerIsOut
}

var currentPcState

# Called when the node enters the scene tree for the first time.
func _ready():
	currentPcState = PCState.playerIsOut



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match currentPcState:
		PCState.playerIsIn:
			if Input.is_action_just_pressed("Menu"):
				exitPC()
		
		#	esc, we le
	

#		change player camera, change controls(take them away)

#							TOWERDEFENCE PERSPECTIVE будет ребенком нода РС
#			у нас будет РС обьект и в качестве детей мі кладем разніе ноді с камерами и будет
#				функция что меняет камеру на ту что была указана в аргументе
func exitPC():
	towerDefenceView.perspectiveLeft()
	playerCharacter.givePlayerMovement()
	playerCharacter.setPlayerCameraAsCurrent()
	currentPcState = PCState.playerIsOut
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func enterPC():
	towerDefenceView.setUpPerspective()
	playerCharacter.takeAwayPlayerMovement()
	currentPcState = PCState.playerIsIn
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func changePerspective(perspectiveObject):
	pass

func _on_interactable_interacted(interactor):
	enterPC()

