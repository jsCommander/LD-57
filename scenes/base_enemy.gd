class_name BaseEnemy extends CharacterBody2D

var hitpoint: Hitpoint = Hitpoint.new()
@export var hit_cooldown: float = 1.0

var current_hit_cooldown: float = 0.0

func _ready():
	hitpoint.value = 100
	hitpoint.max_value = 100
	hitpoint.health_depleted.connect(_death)

func _physics_process(delta: float) -> void:
	if current_hit_cooldown > 0.0:
		current_hit_cooldown -= delta

	velocity.y += G.gravity * delta
	move_and_slide()

func hit(damage: int) -> void:
	if current_hit_cooldown > 0.0:
		return

	hitpoint.take_damage(damage)
	Logger.log_info(self.name, "hit for %s" % damage)
	current_hit_cooldown = hit_cooldown

func _death():
	queue_free()
