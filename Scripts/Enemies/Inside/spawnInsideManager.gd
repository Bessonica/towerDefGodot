extends Node3D

#await get_tree().create_timer(10).timeout
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("enemyDugDown", spawnInRandomPlace)
	#await get_tree().create_timer(5).timeout
	#spawnInRandomPlace()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func spawnInRandomPlace():
	var spawnPoints = []
	var allSpawnPoints = get_children()
	#var spawnPointsAmount = get_child_count()
	for spawnPoint in allSpawnPoints:
		if spawnPoint.currentSpawnPointState == spawnPoint.spawnPointState.deactivated:
			spawnPoints.append(spawnPoint)
	
	var spawnPointsAmount = spawnPoints.size()
	if spawnPointsAmount >= 1:
		var randomIndex = randi_range(0, spawnPointsAmount - 1)
		spawnPoints[randomIndex].startSpawning()
