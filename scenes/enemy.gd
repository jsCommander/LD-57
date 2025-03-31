class_name Enemy extends CharacterBody2D

@export var speed: float = 100.0

@onready var hit: AudioStreamPlayer = $Hit

var hitpoint: Hitpoint = Hitpoint.new()

func _ready() -> void:
	hitpoint.health_depleted.connect(_on_health_depleted)
	hitpoint.health_changed.connect(_on_hit)
	
func _physics_process(delta: float) -> void:
	var player = G.player

	if not player:
		return
		
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

# Удаляем ноду, когда здоровье закончилось
func _on_health_depleted() -> void:
	call_deferred("queue_free")

func _on_hit(_damage: int) -> void:
	hit.play()

func _on_player_detector_player_detected(player: Player) -> void:
	player.hitpoint.take_damage(1)
