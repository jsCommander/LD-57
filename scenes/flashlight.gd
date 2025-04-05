extends Area2D

@export var hit_cooldown: float = 1.0
@export var hit_damage: int = 10

@onready var fire_sprite: Sprite2D = $Node2D/FireSprite

var current_hit_cooldown: float = 0.0

func _ready() -> void:
	Animations.shake(fire_sprite)

func _physics_process(delta: float) -> void:
	if current_hit_cooldown > 0.0:
		current_hit_cooldown -= delta
		return

	var overlapping_bodies = get_overlapping_bodies()

	for body in overlapping_bodies:
		if body is BaseEnemy:
			body.hit(hit_damage)
			current_hit_cooldown = hit_cooldown
