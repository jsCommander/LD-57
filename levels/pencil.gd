extends Node2D

@onready var tree: Sprite2D = $Tree
@onready var player: Sprite2D = $Player

func _ready() -> void:
	Animations.pulse(player)
	Animations.shake(tree)
