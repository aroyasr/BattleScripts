extends Control
# turn_history.gd
# Manage animation for the turn history timeline scene.
# Instantiates new cells and adds them to an array.
# Displays the 11 most recent turns, by FIFO ordering.

# All cells will be added to Timeline HBOX container, and each time
# a new cell is added the box will be shifted by 150 pixels to the left

# Each cell is 150 Width, 195 Height

@onready var timeline_container = $TimelineContainer

var cell_width = 195
var hbox_start_position: int = 1920
var hbox_position: int = 1920 # This variable will be adjusted by cell width in process
var hbox_destination: int = 1920 # This variable will be adjusted by cell width on new cell added

var num_cells: int = 0

func _ready() -> void:
	if timeline_container.get_child_count() > 0:
		for cell in timeline_container.get_children():
			cell.queue_free()
	
	
