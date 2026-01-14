# root.gd

# This script manages the currently active scene. It also holds global variables.
class_name GameController extends Node

# Variables
var game_controller : GameController
@onready var ui = get_node("current_ui_scene")
var current_ui_scene 

# Functions
func _ready() -> void:
	Root.game_controller = self
	change_ui_scene("res://scenes/main_menu.tscn")

func change_ui_scene(new_scene: String) -> void:
	if current_ui_scene != null:
		current_ui_scene.queue_free() # Remove node entirely
	var new = load(new_scene).instantiate()
	ui.add_child(new)
	current_ui_scene = new
