extends Area3D


var enemiesInRadius
var shootOnce = true

@export var damage: int
@onready var damageLabel = $Label3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
#	get_overlapping_bodies()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	damageLabel.text = var_to_str(damage)





func lookForEnemies():
	var list: Array[Node3D] = get_overlapping_bodies()
	return list
	
func activateOnce():
	enemiesInRadius = lookForEnemies()
	if enemiesInRadius.size() != 0:
		for enemy in enemiesInRadius:
			print("found an enemy")
			enemy.enemyLostSomeHealth(damage)
	queue_free()

#	enemy.enemyLostSomeHealth(damage)

func setUpDamage(value):
	damage = value


func _on_body_entered(body):
	body.enemyLostSomeHealth(damage)
	print("hey")

