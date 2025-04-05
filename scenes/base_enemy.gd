class_name BaseEnemy extends CharacterBody2D

@export var max_hitpoint: int = 30

signal death(enemy: BaseEnemy)

var hitpoint: Hitpoint = Hitpoint.new()

func _ready():
	hitpoint.value = max_hitpoint
	hitpoint.max_value = max_hitpoint
	hitpoint.health_depleted.connect(_death)

func _physics_process(delta: float) -> void:
	velocity.y += G.gravity * delta

func hit(damage: int) -> void:
	hitpoint.take_damage(damage)
	Logger.log_info(self.name, "hit for %s" % damage)

func _death():
	death.emit(self)
	call_deferred("queue_free")
