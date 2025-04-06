class_name Door extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func open() -> void:
	collision_shape_2d.disabled = true
	animation_player.play("open")
	AM.play_sound(G.GameSounds.NEW_LEVEL)
