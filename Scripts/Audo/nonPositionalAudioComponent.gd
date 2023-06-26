extends Node3D

@export var audioList : Array[AudioStreamPlayer]
@onready var backGroundAudio = $BackgroundAmbient

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func playAudio():
	backGroundAudio.play()
	
func stopAudio():
	backGroundAudio.stop()
	
