extends Node2D

func _ready() -> void:
	SM.add_scene(T.GameScreens.SPLASH_SCREEN, "res://scenes/splash_screen.tscn")
	SM.add_scene(T.GameScreens.WIN_SCREEN, "res://scenes/win_screen.tscn")
	SM.add_scene(T.GameScreens.LOOSE_SCREEN, "res://scenes/lose_screen.tscn")
	SM.add_scene(T.GameScreens.LEVEL1, "res://levels/level_1.tscn")
	SM.change_scene(T.GameScreens.SPLASH_SCREEN)
