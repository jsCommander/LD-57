extends Node2D

func _ready() -> void:
	SM.add_scene(T.GameScreens.SPLASH_SCREEN, "res://scenes/splash_screen.tscn")
	SM.add_scene(T.GameScreens.WIN_SCREEN, "res://scenes/win_screen.tscn")
	SM.add_scene(T.GameScreens.LEVEL1, "res://levels/level_1.tscn")
	SM.add_scene(T.GameScreens.LEVEL2, "res://levels/level_2.tscn")
	SM.add_scene(T.GameScreens.LEVEL3, "res://levels/level_3.tscn")

	SM.change_scene(T.GameScreens.LEVEL1)
