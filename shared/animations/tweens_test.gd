extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var sprite_2d_3: Sprite2D = $Sprite2D3

func _ready():
	Animations.fade_in(sprite_2d)
	Animations.pulse(sprite_2d)

	Animations.fade_in(sprite_2d_2)
	Animations.shake(sprite_2d_2)

	Animations.fade_in(sprite_2d_3)
	Animations.bounce(sprite_2d_3)
