class_name BaseLevel extends Node2D

@export var next_level: G.GameScreens
@export var level_name: String

var door: Door
var enemies: Array[BaseEnemy] = []

func _ready():
	_send_event()
	door = get_node_or_null("Door")

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
		if door:
			door.open()

func _send_event() -> void:
	if not G.send_events:
		return

	Logger.log_info(self.name, "Sending event: %s" % level_name)
	Analytics.add_event(level_name, {
		deaths = G.player_death_count,
		time_played = G.time_played,
	})
