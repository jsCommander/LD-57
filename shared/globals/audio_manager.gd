class_name SoundManager extends Node

@export var max_players: int = 10

var players: Array[AudioStreamPlayer] = []
var busy_players: Dictionary[AudioStreamPlayer, bool] = {}
var playing_sounds: Dictionary[int, bool] = {} # sound_type -> bool
var sounds: Dictionary[int, String] = {} # sound_type -> path

func _ready():
	for i in max_players:
		var player = AudioStreamPlayer.new()
		add_child(player)
		players.append(player)
		busy_players[player] = false

	Logger.log_info(self.name, "Sound manager ready, added %d players" % max_players)

func add_sound(sound_type: int, path: String) -> void:
	if not ResourceLoader.exists(path):
		Logger.log_error(self.name, "Sound path not found: %s" % path)
		return

	sounds[sound_type] = path

func play_sound(sound_type: int, is_loop: bool = false):
	if playing_sounds.get(sound_type):
		return null

	var stream_path = sounds.get(sound_type, null)

	if not stream_path:
		Logger.log_error(self.name, "Unknown sound type: %s" % str(sound_type))
		return null

	var stream = load(stream_path)
	if not stream:
		Logger.log_error(self.name, "Failed to load stream: %s" % stream_path)
		return null

	var player := _get_free_player()

	if not player:
		Logger.log_error(self.name, "No free audio players!")
		return null

	
	# allocate resources
	playing_sounds[sound_type] = true
	busy_players[player] = true

	player.stream = stream
	player.play()

	await player.finished
	
	# Free resources
	playing_sounds[sound_type] = false
	busy_players[player] = false
	player.stream = null

	# If the sound is looped, play it again
	if is_loop:
		play_sound(sound_type, true)

func _get_free_player() -> AudioStreamPlayer:
	for player in players:
		if not busy_players[player]:
			return player

	return null
