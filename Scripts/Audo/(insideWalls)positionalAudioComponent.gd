extends "res://Scripts/Audo/positionalAudioComponent.gd"

@onready var soundOne = $SoundOne
@onready var soundTwo = $SoundTwo

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func playAudioOne():
	playSound(soundOne)

func playRandomSound():
	var randomNumber = randi_range(0, get_child_count() - 1)
	var soundToPlay = get_child(randomNumber)
	if soundToPlay != null:
		playSound(soundToPlay)
