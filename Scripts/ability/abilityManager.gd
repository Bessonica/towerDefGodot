extends Area3D

@export var bombingDamage: int
@export var bombingCooldown: float
var canBomb: bool

var damageCone = preload("res://Scenes/ability/damageCone.tscn")
@onready var timer = $BombTimer

signal bombingIsOn



# Called when the node enters the scene tree for the first time.
func _ready():
	canBomb = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func startBombCoolDown():
	timer.start()
func stopBombCoolDown():
	timer.stop()

func bombing(position):
	#await get_tree().create_timer(1.5).timeout
	var bombingCone = damageCone.instantiate()
	bombingCone.setUpDamage(bombingDamage)
	bombingCone.global_position = position
	add_child(bombingCone)
	bombingIsOn.emit()
	Events.emit_signal("bombingHappened")
	await get_tree().create_timer(0.25).timeout
	bombingCone.queue_free()
	#print("BOOM")
	
func useAbility(position, abilityIndex):
	if abilityIndex == 11 && canBomb:
		bombing(position)
		canBomb = false
		startBombCoolDown()
	else:
		print("dont recognize abilityIndex")


func getTimerPercentage():
	var percentage = (timer.wait_time - timer.time_left)/(timer.wait_time) * 100
	return percentage


func _on_bomb_timr_timeout():
	canBomb = true
	stopBombCoolDown()
