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
	TUNNEL1,
	TUNNEL2,
	LOOSE_SCREEN,
	WIN_SCREEN,
}

enum GameSounds {
	INNER_BEAST,
	UNLIT_CORNERS,
	NEW_LEVEL,
	ENEMY_DEATH,
	PLAYER_DEATH,
}

func _ready():
	SM.add_scene(GameScreens.SPLASH_SCREEN, "res://scenes/splash_screen.tscn")
	SM.add_scene(GameScreens.WIN_SCREEN, "res://scenes/win_screen.tscn")
	SM.add_scene(GameScreens.LEVEL1, "res://levels/level_1.tscn")
	SM.add_scene(GameScreens.LEVEL2, "res://levels/level_2.tscn")
	SM.add_scene(GameScreens.LEVEL3, "res://levels/level_3.tscn")
	SM.add_scene(GameScreens.LEVEL4, "res://levels/level_4.tscn")
	SM.add_scene(GameScreens.LEVEL5, "res://levels/level_5.tscn")
	SM.add_scene(GameScreens.LEVEL6, "res://levels/level_6.tscn")
	SM.add_scene(GameScreens.TUNNEL1, "res://levels/transition_tunnel_1.tscn")
	SM.add_scene(GameScreens.TUNNEL2, "res://levels/transition_tunnel_2.tscn")

	AM.add_sound(GameSounds.INNER_BEAST, "res://assets/soundtrack/inner_beast.wav", -10.0)
	AM.add_sound(GameSounds.UNLIT_CORNERS, "res://assets/soundtrack/unlit_corners_2.wav", -10.0)
	AM.add_sound(GameSounds.NEW_LEVEL, "res://assets/sfx/new_lvl.wav")
	AM.add_sound(GameSounds.ENEMY_DEATH, "res://assets/sfx/enemy_death.wav")
	AM.add_sound(GameSounds.PLAYER_DEATH, "res://assets/sfx/player_death.wav")
	
	AM.rotate_sounds([G.GameSounds.INNER_BEAST, G.GameSounds.UNLIT_CORNERS])
