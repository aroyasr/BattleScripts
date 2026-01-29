extends Control

# match.gd
# Run the match.
# Start gm_main python script, get result from imported scripts each turn.
# Display results between turns. Manage waiting and animations.

enum matchState {
	AWAIT_INPUT,
	GET_RESULT,
	AWAIT_RESULT,
	DISPLAY_RESULT,
}

var current_state: matchState = matchState.AWAIT_INPUT
var next_pressed: bool = false
var result_received: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	py_init(Root.p1_script_path, Root.p2_script_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if current_state == matchState.AWAIT_INPUT && next_pressed:
		next_pressed = false
		change_state(matchState.GET_RESULT)
	
	if current_state == matchState.GET_RESULT:
		py_get_turn_results()
		change_state(matchState.AWAIT_RESULT)
	
	if current_state == matchState.AWAIT_RESULT:
		pass
	
	if current_state == matchState.DISPLAY_RESULT:
		pass


func change_state(new_state: matchState):
	current_state = new_state

func py_init(script1_path: String, script2_path: String):
	$PythonFriend.python_run("init", {"script1_path": script1_path, "script2_path": script2_path})
	
func py_get_turn_results():
	$PythonFriend.python_run("get_turn_results", {})
	
func _on_button_exit_pressed() -> void:
	Root.game_controller.change_ui_scene("res://scenes/main_menu.tscn")


func _on_button_next_pressed() -> void:
	if current_state == matchState.AWAIT_INPUT:
		next_pressed = true


func _on_python_friend_python_output(output: Variant, is_error: Variant) -> void:
	print(output)
	print(is_error)
	change_state(matchState.AWAIT_INPUT)
