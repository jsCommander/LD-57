extends CanvasLayer

@export var next_scene: G.GameScreens

func _ready() -> void:
	pass

func _handle_start_pressed() -> void:
	Analytics.add_event("start pressed")
	SM.change_scene(next_scene)

func _handle_exit_pressed() -> void:
	Logger.log_info(self.name, "Exit pressed")
	get_tree().quit()
