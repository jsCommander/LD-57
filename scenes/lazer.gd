class_name Lazer extends Area2D

@export var speed: float = 800.0
@export var lifetime: float = 2.0
@export var reflect_cooldown: float = 0.05
@export var start_damage: int = 1
@export var reflect_damage_multiplier: float = 1.5

@onready var line: Line2D = $line
@onready var peak: Line2D = $peak

enum LazerForm {
	LINE,
	PEAK,
}

var direction: Vector2 = Vector2.RIGHT
var reflect_timer: float = 0.0
var can_reflect: bool = false
var current_damage: int = start_damage
var form: LazerForm = LazerForm.LINE

func _ready() -> void:
	# Уничтожаем лазер через заданное время
	var timer = get_tree().create_timer(lifetime)
	timer.timeout.connect(_on_lifetime_timeout)
	set_damage(start_damage)
	set_form(form)

func _physics_process(delta: float) -> void:
	reflect_timer += delta
	if reflect_timer >= reflect_cooldown:
		reflect_timer = 0.0
		can_reflect = true

	# Перемещение в заданном направлении
	position += direction * speed * delta
	# Поворачиваем лазер в направлении движения
	rotation = direction.angle()

func _on_lifetime_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.hitpoint.take_damage(current_damage)
		queue_free()

func set_form(new_form: LazerForm) -> void:
	form = new_form
	match form:
		LazerForm.LINE:
			line.visible = true
			peak.visible = false
		LazerForm.PEAK:
			line.visible = false
			peak.visible = true

func set_damage(new_damage: int) -> void:
	current_damage = new_damage
	Logger.log_info(self.name, "Lazer damage: %s" % current_damage)
