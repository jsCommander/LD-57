class_name Player extends CharacterBody2D

enum State {
	WALK,
	IN_AIR
}

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 980.0
@export var ladder_speed: float = 200.0

@onready var ladder_left_timer: Timer = $LadderLeftTimer
@onready var body: Node2D = $Body

var current_state: State = State.WALK
var near_ladder: bool = false

func _physics_process(delta):
	match current_state:
		State.WALK:
			process_walk_state(delta)
		State.IN_AIR:
			process_in_air_state(delta)
	
	move_and_slide()

func process_walk_state(_delta):
	_process_gravity(_delta)
	_process_moving(_delta)

	if near_ladder:
		_process_ladder_moving(_delta)

	if !is_on_floor() and !near_ladder:
		_change_state(State.IN_AIR)

func process_in_air_state(_delta):
	_process_gravity(_delta)
	_process_moving(_delta)

	if near_ladder:
		_process_ladder_moving(_delta)
	
	if is_on_floor():
		_change_state(State.WALK)

func _process_gravity(_delta):
	velocity.y += gravity * _delta

func _process_moving(_delta):
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if velocity.x > 0:
		body.scale.x = 1
	elif velocity.x < 0:
		body.scale.x = -1

func _process_ladder_moving(_delta):
	var direction = Input.get_axis("move_up", "move_down")
	if direction:
		velocity.y = direction * ladder_speed
	else:
		velocity.y = move_toward(velocity.y, 0, ladder_speed)

func _change_state(new_state: State):
	var old_state = current_state
	current_state = new_state

	Logger.log_info(self.name, 'state changed from %s to %s' % [_get_state_name(old_state), _get_state_name(new_state)])

func _get_state_name(state: State) -> String:
	return Utils.get_enum_key_name(State, state)

func _on_ladder_detector_body_entered(_body: Node2D) -> void:
	if !ladder_left_timer.is_stopped():
		ladder_left_timer.stop()
		Logger.log_info(self.name, 'ladder entered, stop timer')
		
	Logger.log_info(self.name, 'ladder entered')
	near_ladder = true

func _on_ladder_detector_body_exited(_body: Node2D) -> void:
	ladder_left_timer.start()
	Logger.log_info(self.name, 'ladder left, start timer')


func _on_ladder_left_timer_timeout() -> void:
	Logger.log_info(self.name, 'ladder left timer timeout')
	near_ladder = false
