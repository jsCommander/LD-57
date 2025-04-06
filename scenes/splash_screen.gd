extends CanvasLayer

@export var next_scene: G.GameScreens
@onready var patient: Sprite2D = $patient
@onready var player: Sprite2D = $player
@onready var title: Sprite2D = $title

func _ready() -> void:
	Animations.shake(patient)
	Animations.shake(player)
	Animations.shake(title)

func _handle_start_pressed() -> void:
	Analytics.add_event("start pressed")
	SM.change_scene(next_scene)

func _handle_exit_pressed() -> void:
	Logger.log_info(self.name, "Exit pressed")
	get_tree().quit()
