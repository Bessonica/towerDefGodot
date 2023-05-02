extends CharacterBody3D


@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = $CameraPivot
@onready var camera = $CameraPivot/Camera3D

var mouse_sense = 0.1

enum playerState{
	canMove,
	cannotMove
}

var currentPlayerState = playerState.canMove

func _ready():
	#hides the cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	#get mouse input for camera rotation
	match currentPlayerState:
		playerState.canMove:
			if event is InputEventMouseMotion:
				rotate_y(deg_to_rad(-event.relative.x * mouse_sense))
				head.rotate_x(deg_to_rad(-event.relative.y * mouse_sense))
				head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
		playerState.cannotMove:
			pass
		

func _physics_process(delta):
	match currentPlayerState:
		playerState.canMove:
			# Add the gravity.
			if not is_on_floor():
				velocity.y -= gravity * delta

			# Handle Jump.
			if Input.is_action_just_pressed("ui_accept") and is_on_floor():
				velocity.y = JUMP_VELOCITY
	
			#	show mouse when press "esc", so it easier to close window
			if Input.is_action_just_pressed("Menu"):
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		
			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.
			var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
			var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			if direction:
				velocity.x = direction.x * SPEED
				velocity.z = direction.z * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				velocity.z = move_toward(velocity.z, 0, SPEED)

			move_and_slide()
			
		playerState.cannotMove:
			pass
			
			
			
func takeAwayPlayerMovement():
	currentPlayerState = playerState.cannotMove
	
func givePlayerMovement():
	currentPlayerState = playerState.canMove
	
func returnCamera():
	return camera
