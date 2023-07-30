extends Node3D

var panelMeshSize
@onready var viewport = $SubViewport
@onready var subViewportContainer = $SubViewportContainer
@onready var panelMesh = $MeshInstance3D
@onready var panelArea = $MeshInstance3D/Area3D

var is_mouse_held = false
var is_mouse_inside = false

var lastMousePoistion2D = null
var lastMousePosition3D = null


func _ready():
	panelArea.mouse_entered.connect(mouseEnteredPanelArea)


func testMouse():
	print("HEEEEY MOUSE ENTERED")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func mouseEnteredPanelArea():
	is_mouse_inside = true
	print("mouse entered area")


