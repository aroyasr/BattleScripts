extends Window
## This script is for error handling when loading a file in the MatchSetup.tscn scene.
## It is connected to the Window_errormsg node.

func _ready():
	self.title = "Error when loading script"

func add_error(errormsg: String):
	var error = Label.new()
	error.text = errormsg
	$PanelContainer/VBoxContainer.add_child(error)

func _on_close_requested() -> void:
	self.hide()
