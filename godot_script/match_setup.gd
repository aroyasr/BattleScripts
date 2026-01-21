extends Control

## match_setup.gd
## contain methods for picking match settings.
## store location of python files.
## don't allow user to start game without picking 2 files.

@onready var fd_loadp1 = $FD_loadp1
@onready var fd_loadp2 = $FD_loadp2

var p1_filepath: String
var p1_filename: String
var p2_filepath: String
var p2_filename: String

var autoplay: bool
var record_match: bool

## validate_script: 
## - Validate the given file has the proper functions needed: use external script
## - Return null if invalid
## - Return name of script if valid
func validate_script(path: String):
	var pystdout = []
	# Convert res:// path to absolute filesystem path
	var validator_script = ProjectSettings.globalize_path("res://python_script/file_validator.py")
	var script_path = ProjectSettings.globalize_path(path)
	
	var result = OS.execute("python", [validator_script, script_path], pystdout)
	
	# Check if execution was successful (return code 0)
	if result != 0:
		# Validation failed - print errors
		if pystdout.size() > 0:
			print("Validation errors:")
			for error in pystdout:
				print(error)
		return null
	
	# Validation passed - extract script name from output
	if pystdout.size() > 0:
		var script_name = pystdout[0].strip_edges()
		print("Script validated: " + script_name)
		return script_name
	
	return null


# Typical godot functions

# Setting title in inspector does not work so have to do this
func _ready():
	fd_loadp1.title = "Open Player 1 Script"
	fd_loadp2.title = "Open Player 2 Script"

# Button Signals
func _on_button_back_pressed() -> void:
	Root.main_menu()
	
func _on_button_loadfilep_1_pressed() -> void:
	fd_loadp1.visible = true
func _on_button_loadfilep_2_pressed() -> void:
	fd_loadp2.visible = true

# Filedialog signals
func _on_fd_loadp_1_file_selected(path: String) -> void:
	var script_name = validate_script(path)
	if script_name != null:
		p1_filename = script_name
		print("_on_fd_loadp_1_file_selected: " , script_name)
