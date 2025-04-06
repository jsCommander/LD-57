@tool

extends Area2D

@export_multiline var text: String

@onready var label:Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	label.modulate.a = 0.0
	label.text = text

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		label.modulate.a = 1.0
		label.text = text

func show_text() -> void:
	animation_player.play("fade_in")
	await animation_player.animation_finished
	animation_player.play("shake")

func hide_text() -> void:
	animation_player.play_backwards("fade_in")

func _on_body_entered(_body: Node2D) -> void:
	show_text()


func _on_body_exited(_body: Node2D) -> void:
	hide_text()
