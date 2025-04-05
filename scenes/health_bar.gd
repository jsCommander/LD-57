extends ProgressBar

@export var target: Node2D

func _ready() -> void:
	if not target:
		Logger.log_error(self.name, "target is not set")
		return

	if not target.hitpoint:
		Logger.log_error(self.name, "target has no hitpoint")
		return

	target.hitpoint.health_changed.connect(_on_health_changed)

	max_value = target.hitpoint.max_value
	value = target.hitpoint.value
	

func _on_health_changed(new_health: int) -> void:
	value = new_health
