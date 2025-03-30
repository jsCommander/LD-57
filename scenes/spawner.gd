extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 1.0

var spawn_points: Array[Node2D] = []
var spawn_timer: float = 0.0

func _ready() -> void:
	for child in get_children():
		if child is Node2D:
			spawn_points.append(child)

func _process(delta: float) -> void:
	spawn_timer += delta

	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_enemy()

func spawn_enemy() -> void:
	var spawn_point = spawn_points[randi() % spawn_points.size()]
	var enemy = enemy_scene.instantiate()
	enemy.global_position = spawn_point.global_position
	get_parent().add_child(enemy)
