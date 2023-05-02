extends Interactor

@export var player: CharacterBody3D

#var playerCamera = player.returnCamera()

var choosenInteractable: Interactable
@onready var rayCast = $RayCast3D



#	прикрепляем этот рейкаст к камере и проверяем есть ли коллайд

# Called when the node enters the scene tree for the first time.
func _ready():
	controller = player
	
	#rayCast.add_exception(controller)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("collision is going")
	if rayCast.is_colliding():
		print("collision")


