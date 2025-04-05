class_name EventBus extends Node

signal player_death

func _ready():
	player_death.connect(func():
		Logger.log_info(self.name, "Player death event triggered")
	)
