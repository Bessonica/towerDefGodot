extends Node3D

@export var damage = 5
@export var playerScene: Node3D

@onready var timer = $Timer
@onready var flameArea = $Area3D
@onready var particles = $GPUParticles3D
@onready var lightComponent = $OmniLight3D
@onready var hand = $"."


@export var activated: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	lightComponent.hide()
	activated = true

func _input(event):
	if activated == false:
		return

	if event is InputEventMouseMotion:
		hand.weaponSway(Vector2(event.relative.x, event.relative.y))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if activated == false:
		return
	
	hand.position.x = lerp(hand.position.x, 0.0, delta*5)
	hand.position.y = lerp(hand.position.y, 0.0, delta*5)
	
	if Input.is_action_just_pressed("Fire") && playerScene.currentPlayerState  ==  playerScene.playerState.canMove:
		timer.start()
		lightComponent.show()
		particles.emitting = true
	if Input.is_action_just_released("Fire"):
		timer.stop()
		lightComponent.hide()
		particles.emitting = false

func deActivateWeapon():
	activated = false
	hide()

func activateWeapon():
	activated = true
	visible = true

func toggleWeapon():
	if activated == true:
		deActivateWeapon()
	else:
		activateWeapon()

func weaponSway(amount):
	hand.position.x += amount.x * 0.0003
	hand.position.y += amount.y * 0.0003

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
			spawnPoint.decreaseHealth(damage)
		

