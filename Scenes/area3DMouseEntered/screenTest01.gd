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




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func testInputEvent():
	print("input event")

func _on_interactable_interacted(interactor):
	Player.toggleMouse()
	#pass # Replace with function body.



func _input(event):			#	_unhandled_input(event):		_input(event)
	var is_mouse_event = false
	
	#print("there is input bro")
	#print(event.as_text())
	#		WHY COMPARING event ONLY WORKS WITH "is" AND NOT WITH "=="?
	if event is InputEventMouseMotion:
		is_mouse_event = true
	elif event is InputEventMouseButton:
		is_mouse_event = true
	
	#	WHY THIS FOR LOOP DOESNT WORK?
	#		if event is mouse_event  gives error(could not find type "mose_event"  in the current scope
	#			"==" instead of "is" gives nothing
#	for mouse_event in [InputEventMouseButton, InputEventMouseMotion]:
#		if event == mouse_event:
#			is_mouse_event = true
#			print("there is input bro")
	
	if is_mouse_event and (is_mouse_inside):   #	and (is_mouse_inside or is_mouse_held)
		handle_mouse(event)
	
	#	this part is probably unnecesary
#	elif not is_mouse_event:
#		#viewport.input(event)  #	or .input(event)
#		viewport.push_input(event)
#		#subViewportContainer.input(event)	#	subViewportContainer


func handle_mouse(event):
	panelMeshSize = panelMesh.mesh.size
	
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

	# If the event is a mouse motion event...
	if event is InputEventMouseMotion:
		# If there is not a stored previous position, then we'll assume there is no relative motion.
		if lastMousePoistion2D == null:
			event.relative = Vector2(0, 0)
		# If there is a stored previous position, then we'll calculate the relative position by subtracting
		# the previous position from the new position. This will give us the distance the event traveled from prev_pos
		else:
			event.relative = mouse_pos2D - lastMousePoistion2D
	# Update last_mouse_pos2D with the position we just calculated.
	lastMousePoistion2D = mouse_pos2D

	# Finally, send the processed input event to the viewport.
	#viewport.input(event)
	viewport.push_input(event)
	#subViewportContainer.input(event)



func find_mouse(global_position):
	# Player.returnCamera()
	var camera = Player.returnCamera()
	var from = camera.project_ray_origin(global_position)
	var dist = find_further_distance_to(camera.transform.origin)
	var to = from + camera.project_ray_normal(global_position) * dist


	# Manually raycasts the are to find the mouse position
	#	 PhysicsRayQueryParameters3D
	var query =  PhysicsRayQueryParameters3D.create(from, to, panelArea.collision_layer, [])
	query.collide_with_areas = true
	query.collide_with_bodies = false
	var result = get_world_3d().direct_space_state.intersect_ray(query) #for 3.1 changes

	if result.size() > 0:
		return result.position
	else:
		return null



func find_further_distance_to(origin):
	# Find edges of collision and change to global positions
	var edges = []
	edges.append(panelArea.to_global(Vector3(panelMeshSize.x / 2, panelMeshSize.y / 2, 0)))
	edges.append(panelArea.to_global(Vector3(panelMeshSize.x / 2, -panelMeshSize.y / 2, 0)))
	edges.append(panelArea.to_global(Vector3(-panelMeshSize.x / 2, panelMeshSize.y / 2, 0)))
	edges.append(panelArea.to_global(Vector3(-panelMeshSize.x / 2, -panelMeshSize.y / 2, 0)))

	# Get the furthest distance between the camera and collision to avoid raycasting too far or too short
	var far_dist = 0
	var temp_dist
	for edge in edges:
		temp_dist = origin.distance_to(edge)
		if temp_dist > far_dist:
			far_dist = temp_dist

	return far_dist
