extends Node2D

func _ready() -> void:
	AM.play_sound(G.GameSounds.MAIN_MUSIC)
	SM.change_scene(G.GameScreens.LEVEL1)
