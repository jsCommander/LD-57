class_name BaseLevel extends Node2D

@export var next_level: T.GameScreens

var enemies: Array[BaseEnemy] = []

func _ready():
	for child in get_children():
		if child is BaseEnemy:
			enemies.append(child)
			child.death.connect(_on_enemy_death)

func _process(_delta: float) -> void:
	pass

func _on_enemy_death(enemy: BaseEnemy) -> void:
	enemies.erase(enemy)
	Logger.log_info(self.name, "Enemy %s died" % enemy.name)

	if enemies.size() == 0:
		SM.change_scene(next_level)
