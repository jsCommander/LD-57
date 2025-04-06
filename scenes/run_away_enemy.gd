class_name RunAwayEnemy extends BaseEnemy

@export var speed: float = 300.0

@onready var timer: Timer = $Timer
@onready var triggered_sound: AudioStreamPlayer2D = $TriggeredSound
@onready var body: Node2D = $Body

var is_triggered: bool = false

func _update(_delta: float) -> void:
	if not is_triggered or not G.player:
		return

	var player_position = G.player.position
	var direction = (position - player_position).normalized()

	if direction.x:
		velocity.x = direction.x * speed
		animation_player.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		animation_player.play("idle")

	Utils.look_in_direction_x_invert(body, velocity.x)

func _on_player_detector_body_entered(_body: Node2D) -> void:
	if _body is Player:
		is_triggered = true
		triggered_sound.play()
		Logger.log_info(self.name, "Start running away")

func _on_player_detector_body_exited(_body: Node2D) -> void:
	if is_dead:
		return
		
	if _body is Player:
		timer.start()
		Logger.log_info(self.name, "Start stopping timer")


func _on_timer_timeout() -> void:
	is_triggered = false
	velocity = Vector2.ZERO
	Logger.log_info(self.name, "Stop running away")
