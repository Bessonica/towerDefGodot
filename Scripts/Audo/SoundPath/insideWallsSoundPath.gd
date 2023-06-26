extends Path3D

var pathFollowSound = preload("res://Scenes/Audio/SoundPath/insideWallsPathFollow.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activateSoundPath():
	var soundPathToAdd = pathFollowSound.instantiate()
	add_child(soundPathToAdd)
