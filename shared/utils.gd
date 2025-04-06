# Utils library, contains some useful functions
# Should not contain any game logic or dependencies
class_name Utils extends RefCounted

static func random_point_in_rect(rect: Rect2) -> Vector2:
	return Vector2(
		randf_range(rect.position.x, rect.end.x),
		randf_range(rect.position.y, rect.end.y)
	)

static func get_direction_to_target(my_position: Vector2, target_position: Vector2) -> Vector2:
	return (target_position - my_position).normalized()

static func get_distance_to_target(my_position: Vector2, target_position: Vector2) -> float:
	return my_position.distance_to(target_position)

static func get_direction_from_target(my_position: Vector2, target_position: Vector2) -> Vector2:
	return (my_position - target_position).normalized()

static func get_random_direction() -> Vector2:
	var direction := Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	return direction

static func get_enum_key_name(_enum, key) -> String:
	return _enum.find_key(key)

static func get_timestamp() -> String:
	return Time.get_datetime_string_from_system(true)

static func look_in_direction_x(body: Node2D, direction_x: float) -> void:
	if direction_x > 0:
		if body.scale.x < 0:
			body.scale.x = body.scale.x * -1
	elif direction_x < 0:
		if body.scale.x > 0:
			body.scale.x = body.scale.x * -1

static func look_in_direction_x_invert(body: Node2D, direction_x: float) -> void:
	if direction_x > 0:
		if body.scale.x > 0:
			body.scale.x = body.scale.x * -1
	elif direction_x < 0:
		if body.scale.x < 0:
			body.scale.x = body.scale.x * -1
