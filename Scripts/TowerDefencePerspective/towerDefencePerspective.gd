extends Node3D


@onready var Camera = $Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func returnCamera():
	return Camera

func setUpPerspective():
	Camera.make_current()
