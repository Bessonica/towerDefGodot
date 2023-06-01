extends Node3D

# counts how many enemies reached the end, and how many waves ended

@onready var enemyScene = preload("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#enemyScene.enemyDugDown.connect(printInfo)
	Events.connect("enemyDugDown", printInfo)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func printInfo():
	print("enemy dug down")

