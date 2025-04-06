extends Node2D

func _ready() -> void:
	AM.rotate_sounds([G.GameSounds.INNER_BEAST, G.GameSounds.UNLIT_CORNERS])
	SM.change_scene(G.GameScreens.SPLASH_SCREEN)
