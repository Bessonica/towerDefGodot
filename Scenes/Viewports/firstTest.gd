extends Node3D

var panelMeshSize
@onready var viewport = $SubViewport
@onready var panelMesh = $MeshInstance3D
@onready var panelArea = $MeshInstance3D/Area3D

var is_mouse_held = false
var is_mouse_inside = false

var lastMousePoistion2D = null
var lastMousePosition3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	panelArea.connect("mouse_entered", mouseEnteredPanelArea)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interactable_interacted(interactor):
	Player.toggleMouse()
	#pass # Replace with function body.

func mouseEnteredPanelArea():
	is_mouse_inside = true
	print("mouse entered area")

func _input(event):
	var is_mouse_event = false
	
	for mouse_event in [InputEventMouseButton, InputEventMouseMotion]:
		if event == mouse_event:
			is_mouse_event = true
	if is_mouse_event:   #	and (is_mouse_inside or is_mouse_held)
		handle_mouse(event)
	elif not is_mouse_event:
		viewport.event(event)  #	or .input(event)
			
func handle_mouse(event):
	if event is InputEventMouseButton:
		is_mouse_held = event.pressed
	
	var mouse_pos3D = find_mouse(event.global_position)
	
	is_mouse_inside = mouse_pos3D != null
	if is_mouse_inside:
		mouse_pos3D = panelArea.global_transform.affine_inverse() * mouse_pos3D
	else:
		mouse_pos3D = lastMousePoistion2D
		if mouse_pos3D == null:
			mouse_pos3D = Vector3.ZERO
			
	var mouse_pos2D = Vector2(mouse_pos3D.x, -mouse_pos3D.y)	
	
	mouse_pos2D.x += panelMeshSize.x / 2
	mouse_pos2D.y += panelMeshSize.y / 2

	mouse_pos2D.x = mouse_pos2D.x / panelMeshSize.x
	mouse_pos2D.y = mouse_pos2D.y / panelMeshSize.y
	
	mouse_pos2D.x = mouse_pos2D.x * viewport.size.x
	mouse_pos2D.y = mouse_pos2D.y * viewport.size.y

	event.position = mouse_pos2D
	event.global_position = mouse_pos2D
	
func find_mouse(global_position):
	pass
	
	
	
	
	
