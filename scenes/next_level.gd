class_name NextLevel extends Node

@export var next_level: G.GameScreens
@export var timeout: float = 1.0

var is_active: bool = false
var is_next_level_called: bool = false

func _physics_process(delta: float) -> void:
	if not is_active or is_next_level_called:
		return

	timeout -= delta
	
	if timeout <= 0:
		SM.change_scene(next_level)
		is_next_level_called = true


func _on_body_entered(body: Node2D) -> void:
	if body is Player and not is_active:
		is_active = true
