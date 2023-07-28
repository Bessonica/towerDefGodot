extends Node3D

#await get_tree().create_timer(10).timeout
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(4).timeout
	startRandomPath()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func startRandomPath():
	var randomNumber = randi_range(0, get_child_count() - 1)
	startSpecificPath(randomNumber)

func startSpecificPath(index):
	var pathToStart = get_child(index)
	if pathToStart != null:
		pathToStart.activateSoundPath()

