extends Area2D

@export var reflect_angle: float = 45.0
@export var reflect_count: int = 2
@export var life_time: float = 10.0
@export var reflect_damage_multiplier: float = 2.0

signal laser_reflected(reflected_lasers)

var timer: float = 0.0

# Предзагрузка сцены лазера
const LazerScene = preload("res://scenes/lazer.tscn")

func _ready():
	# Подключаем сигнал для обнаружения вхождения объекта
	area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	timer += delta
	if timer >= life_time:
		call_deferred("queue_free")

# Вызывается при вхождении другого объекта в нашу область
func _on_area_entered(area):
	# Проверяем, является ли объект лазером
	if area is Lazer and area.can_reflect:
		# Откладываем всю обработку, чтобы избежать изменения физического состояния
		call_deferred("_reflect_laser", area)

# Новый метод для отражения лазера, который будет вызван отложенно
func _reflect_laser(area):
	if !is_instance_valid(area):
		return
		
	var incoming_direction = area.direction.normalized()
	var reflected_lasers = []

	# Центр симметрии — входящий вектор
	# Распределяем отражения симметрично вокруг него
	var angle_offset = reflect_angle * (reflect_count - 1) / 2.0

	for i in range(reflect_count):
		var angle = - angle_offset + i * reflect_angle
		var reflected_direction = incoming_direction.rotated(deg_to_rad(angle)).normalized()

		var reflected_laser = LazerScene.instantiate()
		reflected_laser.global_position = area.global_position
		reflected_laser.direction = reflected_direction

		get_tree().root.add_child(reflected_laser)
		reflected_laser.set_form(Lazer.LazerForm.PEAK)
		reflected_laser.set_damage(area.current_damage * reflect_damage_multiplier)
		reflected_lasers.append(reflected_laser)

	area.queue_free()
	laser_reflected.emit(reflected_lasers)
