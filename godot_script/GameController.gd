# GameController.gd
# This script manages the currently active scene. It also holds global variables.
class_name GameController extends Node

# Variables
@onready var ui = get_node("current_ui_scene")
var current_ui_scene 
var current_state

# Functions
func _ready() -> void:
	change_ui_scene("res://scenes/main_menu.tscn")

func change_ui_scene(new_scene_path: String):
	var old_scene = ui.get_child(0)
	var new_scene = load(new_scene_path).instantiate()
	current_ui_scene = new_scene
	ui.add_child(new_scene)
	if old_scene != null:
		old_scene.queue_free()
