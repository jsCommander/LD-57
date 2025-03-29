class_name SceneManager extends Node

const LOGGER_NAME = "SceneManager"

var scenes_dict: Dictionary[int, String] = {}

var current_scene: Node = null
var current_scene_key: int = -1

func _ready():
	Logger.log_info(LOGGER_NAME, "Initialized")

func add_scene(key: int, scene_path: String):
	if not ResourceLoader.exists(scene_path):
		Logger.log_error(LOGGER_NAME, "Scene path not found: %s" % scene_path)
		return

	scenes_dict[key] = scene_path

func add_scenes(scenes: Dictionary[int, String]):
	for key in scenes:
		add_scene(key, scenes[key])

func change_scene(new_scene_key: int):
	Logger.log_info(LOGGER_NAME, "Changing scene to: %s" % new_scene_key)
	if new_scene_key == current_scene_key:
		Logger.log_error(LOGGER_NAME, "Already on scene: %s" % new_scene_key)
		return
	
	current_scene_key = new_scene_key
	
	if current_scene:
		Logger.log_info(LOGGER_NAME, "Removing scene: %s" % current_scene.name)
		current_scene.queue_free()
		Logger.log_debug(LOGGER_NAME, "Scene was removed: %s" % current_scene.name)

	var scene_path = scenes_dict.get(new_scene_key)

	if not scene_path:
		Logger.log_error(LOGGER_NAME, "Not found scene path for key: %s" % new_scene_key)
		return

	var scene_resource = load(scene_path)

	var scene_instance = scene_resource.instantiate()
	Logger.log_debug(LOGGER_NAME, "Scene instantiated: %s" % scene_resource.resource_path)

	add_child(scene_instance)
	current_scene = scene_instance
	Logger.log_info(LOGGER_NAME, "Scene %s is active" % scene_instance.name)
