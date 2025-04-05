extends Node

var player: Node2D

var gravity: float = 980.0

enum GameScreens {
	SPLASH_SCREEN,
	LEVEL1,
	LEVEL2,
	LEVEL3,
	LEVEL4,
	LEVEL5,
	LEVEL6,
	LEVEL7,
	LEVEL8,
	LEVEL9,
	LEVEL10,
	LOOSE_SCREEN,
	WIN_SCREEN,
}

func _ready():
	SM.add_scene(GameScreens.SPLASH_SCREEN, "res://scenes/splash_screen.tscn")
	SM.add_scene(GameScreens.WIN_SCREEN, "res://scenes/win_screen.tscn")
	SM.add_scene(GameScreens.LEVEL1, "res://levels/level_1.tscn")
	SM.add_scene(GameScreens.LEVEL2, "res://levels/level_2.tscn")
	SM.add_scene(GameScreens.LEVEL3, "res://levels/level_3.tscn")
