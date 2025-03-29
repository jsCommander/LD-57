extends Camera2D

class_name FollowingCamera

@export var target: Node2D
@export var target_offset_x: float = 0.0
@export var smoothing: float = 5.0

func _physics_process(delta):
	if !target:
		return

	position.x = lerpf(position.x, target.position.x + target_offset_x, smoothing * delta)
