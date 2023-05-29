extends Node3D

@export var damage = 0
@export var playerScene: Node3D

@onready var timer = $Timer
@onready var flameArea = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playerScene.hasWeapon == false:
		return
	
	if Input.is_action_just_pressed("Fire"):
		timer.start()
	if Input.is_action_just_released("Fire"):
		timer.stop()


func _on_timer_timeout():
	var enemies = flameArea.get_overlapping_bodies()
	for enemy in enemies:
		enemy.decreaseHealth(damage)
		enemy.stopEnemy()
		print("enemy lost hp")
		

