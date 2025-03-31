class_name Hitpoint extends Resource

@export var value: int = 5
@export var max_value: int = 5

signal health_changed(new_health: int)
signal health_depleted()

func take_damage(amount: int) -> void:
	if value == 0:
		return

	value = max(value - amount, 0)
	health_changed.emit(value)
	
	if value == 0:
		health_depleted.emit()
