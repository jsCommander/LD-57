extends Node2D

func _ready():
	Analytics.add_event('lazer_prism_viewed')
