extends CharacterBody3D

@export
var speed: float = 4.0
@export
var player: RigidBody3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player:
		# Calculate direction toward the player
		var direction = (player.global_transform.origin - global_transform.origin).normalized()
		
		# Move toward the player
		velocity = direction * speed
		
		# Rotate to face the player
		look_at(player.global_transform.origin, Vector3.UP)
		
		# Apply movement
		move_and_slide()

func _on_area_3d_body_entered(body: Node3D) -> void:
	# Check if the body is a bullet
	print(body.name)
	if body.name == "BodyBullet":
		queue_free()  # Remove the enemy
	elif body == player:
		print("Player detected!")
	else:
		print("Unknown object detected: ", body.name)
