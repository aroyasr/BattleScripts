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

var match_data: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PythonFriend.python_init("init", {"script1_path": Root.p1_script_path, "script2_path": Root.p2_script_path, "GD_OUTPUT": "true", "PY_OUTPUT": "false"})


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if next_pressed && current_state == matchState.AWAIT_INPUT:
		next_pressed = false
		change_state(matchState.GET_RESULT)
	
	if current_state == matchState.AWAIT_INPUT:
		return
	
	# write to comm file to run next turn
	if current_state == matchState.GET_RESULT:
		$PythonFriend.python_run("get_turn_results", {"GD_OUTPUT": "true", "PY_OUTPUT": "false"})
	
	# read comm file until python output saved
	if current_state == matchState.AWAIT_RESULT:
		while true:
			var data = $PythonFriend.read_python_output()
			if data["PY_OUTPUT"] == "true":
				change_state(matchState.DISPLAY_RESULT)
				match_data = data
				break
	
	if current_state == matchState.DISPLAY_RESULT:
		print(match_data)


func change_state(new_state: matchState):
	current_state = new_state


func _on_button_exit_pressed() -> void:
	Root.game_controller.change_ui_scene("res://scenes/main_menu.tscn")


func _on_button_next_pressed() -> void:
	if current_state == matchState.AWAIT_INPUT:
		next_pressed = true
