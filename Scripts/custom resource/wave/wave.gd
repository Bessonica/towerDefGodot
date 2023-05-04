extends Resource
class_name wave

@export var enemyAmount: int
@export var timeToSpawn: float
#var enemyPathFollow = preload("res://enemyPathFollow3D.tscn")
@export var enemyPathFollow: PackedScene

@export var enemyHP: int
@export var enemySpeed: float


# function to change speed

#func _init():
#	enemyPathFollow.setSpeed(enemySpeed)
