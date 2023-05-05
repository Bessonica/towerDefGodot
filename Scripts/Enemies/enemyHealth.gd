extends Node3D


@export var health: int

@onready var hpLabel = $Label3D

signal enemyLostAllHP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#hpLabel.text = var_to_str(health)
	updateHealthLabel(health)
	if health <= 0:
		sendSignalToKillEnemy()


#	when health reaches zero send signal to Enemy status to kill itself

func sendSignalToKillEnemy():
	enemyLostAllHP.emit()

func setHealth(amount):
	health = amount
	
func addHealth(amount):
	health = health + amount
	
func decreaseHealth(amount):
	health = health - amount

func updateHealthLabel(text):
	for node in get_children():
		node.text = var_to_str(text)
	

func _on_enemy_enemy_lost_some_hp(amount):
	decreaseHealth(amount) # Replace with function body.
