extends Interactor

@export var player: CharacterBody3D

#var playerCamera = player.returnCamera()

var choosenInteractable: Interactable
@onready var rayCast = $RayCast3D

signal focuseOn
signal focuseOff



# Called when the node enters the scene tree for the first time.
func _ready():
	controller = player
	
	#rayCast.add_exception(controller)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	choosenInteractable = activateRayCast()
	if choosenInteractable != null:
		focus(choosenInteractable)
		focuseOn.emit()
		#print("found interactable!")
		#interact(choosenInteractable)
	else:
		focuseOff.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('interact'):
		if choosenInteractable != null:
			interact(choosenInteractable)
	
func returnPlayer():
	return player

func activateRayCast() -> Interactable:
	var interactObject: Interactable = null
	var collidedObject: Area3D
	
	if rayCast.is_colliding():
		interactObject = rayCast.get_collider() as Interactable
	return interactObject


#		TODO 	if object has no callable for signal gives error.
#	if i dont need these signals, i still need to make empty callable. messy
#			get_signal_connection_list, or get_signal_list   function could help
func checkIfSignalCallExists(interactableObject: Interactable):
	pass
	
