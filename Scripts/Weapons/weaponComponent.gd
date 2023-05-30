extends Node3D

@export var damage = 5
@export var playerScene: Node3D

@onready var timer = $Timer
@onready var flameArea = $Area3D
@onready var particles = $GPUParticles3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playerScene.hasWeapon == false:
		return
	
	if Input.is_action_just_pressed("Fire") && playerScene.currentPlayerState  ==  playerScene.playerState.canMove:
		timer.start()
		particles.emitting = true
	if Input.is_action_just_released("Fire"):
		timer.stop()
		particles.emitting = false


func _on_timer_timeout():
	var enemies = flameArea.get_overlapping_bodies()
	var spawnPoints = flameArea.get_overlapping_areas()
	for enemy in enemies:
		if enemy.is_in_group("enemiesInside"):
			enemy.decreaseHealth(damage)
			enemy.stopEnemy()
			print("enemy lost hp")
			
	for spawnPoint in spawnPoints:
		if spawnPoint.is_in_group("enemyInsideSpawnPoint"):
			print("enemy spawn point hit")
			spawnPoint.health -= damage
		

