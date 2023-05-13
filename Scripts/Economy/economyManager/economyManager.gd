extends Area3D


@onready var timer = $Timer
@export var buildManager: Node3D


#	buildManager.returnHowManyTurretsIsOn()

#	await get_tree().create_timer(8).timeout

@export var turretAmountLimit = 4
var turretCurrentAmountLimit: int
var turretAmountNow: int

# Called when the node enters the scene tree for the first time.
func _ready():
	turretCurrentAmountLimit = 0
	startTimer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if turretCurrentAmountLimit >= turretAmountLimit:
		stopTimer()


func startTimer():
	timer.start()

func stopTimer():
	timer.stop()
	
func canPlayerBuild():
	turretAmountNow = updateTurretAmount()
	if turretAmountNow >= turretCurrentAmountLimit:
		return false
	else:
		return true

func returnTurretLimitAmount():
	return turretAmountLimit

func returnCurrentTurretLimitAmount():
	return turretCurrentAmountLimit

func updateTurretAmount():
	var turretAmount: int
	turretAmount = buildManager.returnHowManyTurretsIsOn()
	return turretAmount


func _on_timer_timeout():
	if turretCurrentAmountLimit < turretAmountLimit:
		turretCurrentAmountLimit = turretCurrentAmountLimit + 1
	print("increased current tower limit = ", turretCurrentAmountLimit)
