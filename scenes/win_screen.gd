extends CanvasLayer

@export var next_scene: G.GameScreens
@export var wait_time: float = 3.0

@onready var timer: Timer = %Timer

func _ready():
	timer.wait_time = wait_time
	timer.start()
	Analytics.add_event('win_screen_viewed', {
		deaths = G.player_death_count,
		time_played = G.time_played,
	})

func _on_timer_timeout():
	SM.change_scene(next_scene)
