extends CanvasLayer

@export var next_scene: T.GameScreens
@export var wait_time: float = 3.0

@onready var timer: Timer = %Timer

func _ready():
	timer.wait_time = wait_time
	timer.start()

func _on_timer_timeout():
	SM.change_scene(next_scene)
