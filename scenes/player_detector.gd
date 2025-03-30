extends Area2D

@export var cooldown: float = 1.0

signal player_detected(player: Player)

var is_player_detected: bool = false
var cooldown_timer: float = 0.0
var current_player: Player = null

func _process(delta: float) -> void:
	if is_player_detected and cooldown_timer <= 0.0:
		player_detected.emit(current_player)
		cooldown_timer = cooldown
	
	if cooldown_timer > 0.0:
		cooldown_timer -= delta

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_detected = true
		current_player = body


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player_detected = false
		current_player = null
