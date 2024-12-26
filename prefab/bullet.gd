extends Node3D

@export
var bullet_speed: float

var bullet_direction: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%BulletTimer.connect("timeout", queue_free)
	%BulletTimer.wait_time = 1.0
	%BulletTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += bullet_direction * bullet_speed * 25 * delta

# Define an explicit name or tag for identification
func get_type() -> String:
	return "Bullet"
