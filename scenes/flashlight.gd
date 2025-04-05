extends Area2D

func _physics_process(delta: float) -> void:
	var overlapping_bodies = get_overlapping_bodies()

	for body in overlapping_bodies:
		if body is BaseEnemy:
			body.hit(10)
