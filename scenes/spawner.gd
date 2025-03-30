extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var spawn_interval_decrease_per_level: float = 0.1
@export var min_spawn_interval: float = 0.1
@export var decrease_spawn_interval_every_n_seconds: float = 3

var interval_update_timer: float = 0.0
var spawn_points: Array[Node2D] = []
var spawn_timer: float = 0.0

func _ready() -> void:
	for child in get_children():
		if child is Node2D:
			spawn_points.append(child)

func _process(delta: float) -> void:
	spawn_timer += delta
	interval_update_timer += delta

	if interval_update_timer >= decrease_spawn_interval_every_n_seconds:
		update_spawn_interval()
		interval_update_timer = 0.0

	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_enemy()

func spawn_enemy() -> void:
	var spawn_point = spawn_points[randi() % spawn_points.size()]
	var enemy = enemy_scene.instantiate()
	enemy.global_position = spawn_point.global_position
	get_parent().add_child(enemy)

func update_spawn_interval() -> void:
	var old_spawn_interval = spawn_interval
	spawn_interval = max(spawn_interval - spawn_interval_decrease_per_level, min_spawn_interval)
	Logger.log_info(self.name, "Spawn interval decreased from %s to %s" % [old_spawn_interval, spawn_interval])
