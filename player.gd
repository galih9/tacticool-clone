extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

@onready var twist_pivot = $Pivot
@onready var raycast = $RayCast3D
@export
var bullet_prefab : PackedScene

@export
var root_node : Node3D

@export
var shoot_position : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Vector3.ZERO
	input.x = Input.get_axis("move_left","move_right")
	input.z = Input.get_axis("move_up","move_down")
	
	apply_central_force(twist_pivot.basis * input * 1200.0 * delta)
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	twist_pivot.rotate_y(twist_input)
	
	twist_input = 0.0
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
			$Weapon.rotate_y(twist_input)

func shoot() -> void:
	var bullet = bullet_prefab.instantiate()
	root_node.add_child(bullet)
	bullet.position = shoot_position.global_position
	
	bullet.bullet_direction = - shoot_position.global_transform.basis.z
	bullet.look_at(bullet.position + bullet.bullet_direction, Vector3.UP)
	pass
