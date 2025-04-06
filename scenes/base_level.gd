class_name BaseLevel extends Node2D

@export var next_level: G.GameScreens

@onready var door: Door = %Door

var enemies: Array[BaseEnemy] = []

func _ready():
	EB.player_death.connect(_on_player_death)

	for child in get_children():
		if child is BaseEnemy:
			enemies.append(child)
			child.death.connect(_on_enemy_death)

func _on_player_death() -> void:
	SM.restart_scene()

func _on_enemy_death(enemy: BaseEnemy) -> void:
	enemies.erase(enemy)
	Logger.log_info(self.name, "Enemy %s died" % enemy.name)

	if enemies.size() == 0:
		door.open()
