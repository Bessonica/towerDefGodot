extends Camera3D

@onready var camera = $"."
@onready var initialRotation = rotation_degrees as Vector3

var trauma = 0.0
@export var traumaReductionRate = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(5).timeout
	addTraume(1)
	print("added trauma")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	trauma = max(trauma - delta * traumaReductionRate, 0.0)

func addTraume(traumaAmount: float):
	trauma = clamp(trauma + traumaAmount, 0.0, 1.0)

func get_shake_intensity() -> float:
	return trauma * trauma
