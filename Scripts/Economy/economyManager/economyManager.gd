extends Area3D


@onready var timer = $Timer
@export var buildManager: Node3D


#	buildManager.returnHowManyTurretsIsOn()

#	await get_tree().create_timer(8).timeout

signal turretCurrentAmountIsChanged(newValue)
signal timerIsTurnedOff()

@export var turretAmountLimit: int = 4: set = setturretAmountLimit, get = getturretAmountLimit
var turretCurrentAmountLimit: int: set = setCurrentTurretAmount, get = getCurrentTurretAmount
var turretAmountNow: int

enum generatorState{
	generatorIsOn,
	generatorIsOff
}

var currentGeneratorState

func _ready():
	currentGeneratorState = generatorState.generatorIsOff
	turretCurrentAmountLimit = 0
	#await get_tree().create_timer(10).timeout
	#turretAmountLimit = 1

func _process(delta):
	if (turretCurrentAmountLimit >= turretAmountLimit && currentGeneratorState == generatorState.generatorIsOn):
		stopTimer()
	if(timer.is_stopped() && turretCurrentAmountLimit < turretAmountLimit && currentGeneratorState == generatorState.generatorIsOn):
		startTimer()

func canPlayerBuild():
	turretAmountNow = getTurretAmount()
	if (turretAmountNow >= turretCurrentAmountLimit):
		return false
	elif currentGeneratorState != generatorState.generatorIsOn:
		return false
	else:
		return true

func returnTurretLimitAmount():
	return turretAmountLimit

func returnCurrentTurretLimitAmount():
	return turretCurrentAmountLimit
	
func returnCurrentGeneratorState():
	return currentGeneratorState

func getTurretAmount():
	var turretAmount: int
	turretAmount = buildManager.returnHowManyTurretsIsOn()
	return turretAmount

#	when timer reaches end
func _on_timer_timeout():
	if turretCurrentAmountLimit < turretAmountLimit:
		turretCurrentAmountLimit = turretCurrentAmountLimit + 1
		print("increased current tower limit = ", turretCurrentAmountLimit)

func startTimer():
	timer.start()

func stopTimer():
	timer.stop()

func getTimerPercentage():
	var percentage = (timer.wait_time - timer.time_left)/(timer.wait_time) * 100
	return percentage

func generatorTurnedOff():
	currentGeneratorState = generatorState.generatorIsOff
	turretCurrentAmountLimit = 0
	stopTimer()
	timerIsTurnedOff.emit()

func generatorTurnedOn():
	currentGeneratorState = generatorState.generatorIsOn
	turretCurrentAmountLimit = 0
	startTimer()



#	setter, getter
func setCurrentTurretAmount(newValue):
	turretCurrentAmountLimit = newValue
	turretCurrentAmountIsChanged.emit(turretCurrentAmountLimit)
func getCurrentTurretAmount():
	return turretCurrentAmountLimit
	
func setturretAmountLimit(newValue):
	turretAmountLimit = newValue
	if turretAmountLimit > turretCurrentAmountLimit:
		startTimer()
	elif turretAmountLimit < turretCurrentAmountLimit:
		turretCurrentAmountLimit = turretAmountLimit
	
func getturretAmountLimit():
	return turretAmountLimit
