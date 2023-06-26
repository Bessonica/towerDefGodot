extends PathFollow3D

var shouldMove: bool
@onready var audioComponent = $PositionalAudioComponent

@export var movementSpeed: float
var progressRatio = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	startMovement()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shouldMove:
		progress += movementSpeed * delta 
	progressRatio = get_progress_ratio()
	if progressRatio >= 1.0:
		destroyItself()


func startMovement():
	shouldMove = true
func stopMovement():
	shouldMove = false

func setSpeed(amount):
	movementSpeed = amount
func destroyItself():
	queue_free()
