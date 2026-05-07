extends CharacterBody3D

@export var speed: float = 6.0
@export var jump_velocity: float = 4.8
@export var gravity: float = 9.8
@export var mouse_sensitivity: float = 0.18

var rotation_x: float = 0.0
var rotation_y: float = 0.0

@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if neck:
		neck.position.y = 1.6

func _input(event: InputEvent):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotation_y -= event.relative.x * mouse_sensitivity * 0.01
		rotation_x -= event.relative.y * mouse_sensitivity * 0.01
		rotation_x = clamp(rotation_x, -1.25, 1.25)
		
		if neck:
			neck.rotation.x = rotation_x
			rotation.y = rotation_y

func _physics_process(delta: float):
	if not is_on_floor():
		velocity.y -= gravity * delta

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed * 10 * delta)
		velocity.z = move_toward(velocity.z, 0, speed * 10 * delta)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
