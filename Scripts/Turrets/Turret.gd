extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func lookForEnemies():
	var list: Array[Node3D] = get_overlapping_bodies()
	pass
#	var list: Array[Area3D] = get_overlapping_areas()
