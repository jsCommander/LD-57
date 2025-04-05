extends CanvasLayer

@export var title: String
@export var image: Texture2D
@export var audio: AudioStream
@export var next_scene: G.GameScreens

@onready var texture_rect: TextureRect = %TextureRect
@onready var title_label: Label = %TitleLabel
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

func _ready() -> void:
	title_label.text = title
	texture_rect.texture = image
	audio_stream_player.stream = audio
	audio_stream_player.play()

func _handle_start_pressed() -> void:
	SM.change_scene(next_scene)

func _handle_exit_pressed() -> void:
	Logger.log_info(self.name, "Exit pressed")
	get_tree().quit()
