class_name BaseEnemy extends CharacterBody2D

@export var max_hitpoint: int = 30

@onready var animation_player: AnimationPlayer = %AnimationPlayer

signal death(enemy: BaseEnemy)

var hitpoint: Hitpoint = Hitpoint.new()
var is_dead := false

func _ready():
	hitpoint.value = max_hitpoint
	hitpoint.max_value = max_hitpoint
	hitpoint.health_depleted.connect(_death)

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	velocity.y += G.gravity * delta

	_update(delta)
	move_and_slide()

func _update(_delta: float) -> void:
	pass

func hit(damage: int) -> void:
	hitpoint.take_damage(damage)
	Logger.log_info(self.name, "hit for %s" % damage)

func _death():
	is_dead = true
	animation_player.play("death")
	AM.play_sound(G.GameSounds.ENEMY_DEATH)
	await animation_player.animation_finished
	death.emit(self)
	queue_free()
