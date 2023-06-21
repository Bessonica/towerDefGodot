extends Area3D

#@export var playerScene: Node3D
@onready var flamethrowModel = $flamethrow
# Called when the node enters the scene tree for the first time.
func _ready():
	flamethrowModel.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interactable_interacted(interactor):
	var player = interactor.returnPlayer()
	player.toggleWeapon()
	toggleWeaponModel()

func toggleWeaponModel():
	if flamethrowModel.visible == true:
		takeWeapon()
	else:
		putWeapon()

func takeWeapon():
	flamethrowModel.hide()
func putWeapon():
	flamethrowModel.show()
