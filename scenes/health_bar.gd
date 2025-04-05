extends ProgressBar

@export var target: Node2D

func _physics_process(_delta: float) -> void:
	if not target:
		return

	if not target.hitpoint:
		return

	if max_value != target.hitpoint.max_value:
		max_value = target.hitpoint.max_value

	if value != target.hitpoint.value:
		value = target.hitpoint.value
