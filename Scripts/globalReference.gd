extends Node

var playerNode: Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	findPlayer()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func findPlayer():
	var playerNodeArray = get_tree().get_nodes_in_group("Player")
	if playerNodeArray.size() >= 1:
		playerNode = playerNodeArray[0]
