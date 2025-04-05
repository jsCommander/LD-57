class_name AttackEnemy extends BaseEnemy

@export var speed: float = 200.0

@onready var timer: Timer = $Timer

var is_triggered: bool = false

func _physics_process(_delta: float) -> void:
	super._physics_process(_delta)

	if not is_triggered or not G.player:
		move_and_slide()
		return

	var player_position = G.player.position
	var direction = (player_position - position).normalized()

	velocity.x = direction.x * speed
	move_and_slide()

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		is_triggered = true
		Logger.log_info(self.name, "Start chasing player")

func _on_player_detector_body_exited(body: Node2D) -> void:
	if body is Player:
		timer.start()
		Logger.log_info(self.name, "Start stopping timer")


func _on_timer_timeout() -> void:
	is_triggered = false
	velocity = Vector2.ZERO
	Logger.log_info(self.name, "Stop chasing player")
