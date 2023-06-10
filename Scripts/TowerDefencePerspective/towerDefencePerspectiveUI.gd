extends Control

@onready var labelOne = $ButtonLabels/TurretOneLabel
@onready var labelTwo = $ButtonLabels/TurretTwoLabel
@onready var labelBomb = $ButtonLabels/BombLabel

@onready var labelArray = [labelOne, labelTwo, labelBomb]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func changeColor(labelIndex):
	var labelToChange = labelArray[labelIndex]
	labelToChange.set("theme_override_colors/font_color", Color(1, 0, 0))
	for label in labelArray:
		if label != labelToChange:
			label.set("theme_override_colors/font_color", Color(1, 1, 1))


func clearAllColor():
	for label in labelArray:
		label.set("theme_override_colors/font_color", Color(1, 1, 1))
