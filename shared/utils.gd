# Utils library, contains some useful functions
# Should not contain any game logic or dependencies
class_name Utils extends RefCounted

static func random_point_in_rect(rect: Rect2) -> Vector2:
	return Vector2(
		randf_range(rect.position.x, rect.end.x),
		randf_range(rect.position.y, rect.end.y)
	)

static func get_direction_to_target(current_pos: Vector2, target_pos: Vector2) -> Vector2:
	return (target_pos - current_pos).normalized()

static func get_distance_to_target(current_pos: Vector2, target_pos: Vector2) -> float:
	return current_pos.distance_to(target_pos)

static func get_direction_away_from_target(current_pos: Vector2, target_pos: Vector2) -> Vector2:
	return (current_pos - target_pos).normalized()

static func get_random_direction() -> Vector2:
	var direction := Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	return direction

static func get_enum_key_name(_enum, key) -> String:
	return _enum.find_key(key)

static func get_timestamp() -> String:
	return Time.get_datetime_string_from_system(true)
