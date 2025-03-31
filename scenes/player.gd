class_name Player extends CharacterBody2D

@export var speed: float = 300.0
@export var prism_count: int = 10
@export var prism_cooldown: float = 5.0
@export var shoot_cooldown: float = 0.1
@export var log_every_n_shots: int = 300
@export var log_every_n_prisms: int = 5

@onready var body: Node2D = $Body
@onready var marker_2d: Marker2D = $Body/Sprite2D3/Marker2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var lazer_scene = preload("res://scenes/lazer.tscn")
var hitpoint: Hitpoint = Hitpoint.new()
var prism_scene = preload("res://scenes/prism.tscn")
var available_prisms: int
var prism_cooldown_timer: float = 0.0
var shoot_cooldown_timer: float = 0.0
var lazer_used_count: int = 0
var prism_used_count: int = 0

func _ready() -> void:
	G.player = self
	hitpoint.health_depleted.connect(_on_health_depleted)
	hitpoint.health_changed.connect(_on_hit)
	available_prisms = prism_count

func _physics_process(delta: float) -> void:
	# Перемещение по обеим осям
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")
	
	velocity.x = direction_x * speed
	velocity.y = direction_y * speed
	
	move_and_slide()
	
	# Всегда поворачиваем игрока в направлении курсора
	var mouse_pos = get_global_mouse_position()
	var direction_to_mouse = (mouse_pos - global_position).normalized()
	body.rotation = direction_to_mouse.angle()
	
	# Обновляем таймер перезарядки призм
	if available_prisms < prism_count and prism_cooldown_timer <= 0:
		available_prisms += 1
		if available_prisms < prism_count:
			prism_cooldown_timer = prism_cooldown
	
	if prism_cooldown_timer > 0:
		prism_cooldown_timer -= delta
		
	# Обрабатываем стрельбу при зажатой кнопке
	if Input.is_action_pressed("shoot") and shoot_cooldown_timer <= 0:
		shoot()
		shoot_cooldown_timer = shoot_cooldown
		
	if shoot_cooldown_timer > 0:
		shoot_cooldown_timer -= delta

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use_power"):
		spawn_prism()

func shoot() -> void:
	# Получаем направление от маркера к курсору мыши
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - marker_2d.global_position).normalized()
	
	# Создаем лазер в позиции маркера
	var lazer = lazer_scene.instantiate()
	get_parent().add_child(lazer)
	lazer.global_position = marker_2d.global_position
	lazer.direction = direction
	lazer_used_count += 1
	if lazer_used_count % log_every_n_shots == 0:
		Analytics.add_event('lazer_used_count', {
			'lazer_used_count': lazer_used_count
		})


func _on_health_depleted() -> void:
	SM.change_scene(T.GameScreens.LOOSE_SCREEN)
	Analytics.add_event('player_loose')
	
func _on_hit(_damage: int) -> void:
	audio_stream_player_2d.play()

func spawn_prism() -> void:
	if available_prisms <= 0:
		Logger.log_info(self.name, "Нет доступных призм!")
		return
		
	# Получаем позицию мыши
	var mouse_pos = get_global_mouse_position()
	
	# Создаем призму в позиции мыши
	var prism = prism_scene.instantiate()
	get_parent().add_child(prism)
	prism.global_position = mouse_pos
	prism_used_count += 1
	if prism_used_count % log_every_n_prisms == 0:
		Analytics.add_event('prism_used', {
			'prism_used_count': prism_used_count
		})
	# Уменьшаем количество доступных призм и запускаем таймер перезарядки
	available_prisms -= 1
	if available_prisms < prism_count:
		prism_cooldown_timer = prism_cooldown
