# main.py

# Imports the module responsible for Godot-Python communication
import godot_friend
import gm_main

# Module-level variable to hold the game manager object
gm_obj = None

# counter to track number of loops to avoid infinite loops in case of issues with comm_channel.json
loop_counter = 0
threshold = 500000

# Initialise gameManager object. Take scripts paths as params. 
# This function is called by pythonFriend node in godot.
# Returns true if successful, false otherwise.
# params: {
#     "script1_path": str (path to first python script),
#     "script2_path": str (path to second python script)
# }

def init(params): 
	global gm_obj
	script1_path = params.get("script1_path")
	script2_path = params.get("script2_path")
	gm_obj = gm_main.GameManager(script1_path, script2_path, 0, 50)
	godot_friend.show_debug_message("GameManager initialized with scripts:"+ script1_path + " " + script2_path)
	while True:
		data = godot_friend.get_comm_channel_input()
		params = data.get("params", {})

		if params.get('PY_OUTPUT') == "true":
			loop_counter += 1
			if loop_counter > threshold: 
				break
		
		elif params.get('GD_OUTPUT') == "true" and data.get('func') == "get_turn_results":
			loop_counter = 0
			#process turn results and update comm_channel.json with results for godot to read
			turn_results = get_turn_results({})
			godot_friend.set_comm_channel_output({"turn_results": turn_results, "PY_OUTPUT": "true", "GD_OUTPUT": "false"})
			if turn_results["match_finished"]:
				break

# Run main to process 1 turn, then get current state and return it.
# params: {}
def get_turn_results(params): 
	match_finished = gm_obj.main()
	state = gm_obj.get_state()
	return {"turn": state["turn"],
			"p1_money": state["p1_money"], 
			"p2_money": state["p2_money"],
			"p1_last_move": state["p1_last_move"],
			"p2_last_move": state["p2_last_move"],
			"match_finished": match_finished
			}


# This dictionary maps function names (strings) to their corresponding Python functions, allowing Godot to call them by name.
func_map = {
	"init": init, # Initialise gameManager object. Take scripts paths as params
}


if __name__ == "__main__":
	# Sets the name of the Godot application. This is used to create a directory for communication data within 'godot/app_userdata/<app_name>'.
	# Please, use the name set in "application/config/name" Godot property (or in project config --> Application --> Name)
	app_name = "BattleScripts"
	godot_friend.set_app_name(app_name)
	# Makes the Python functions accessible from the Godot application by name.
	godot_friend.add_map(func_map) 
	# Set tkinter debug even in export
	godot_friend.set_debug(True)
	# Processes input from Godot and executes the corresponding Python function.
	godot_friend.ready()
	