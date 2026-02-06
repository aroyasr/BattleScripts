extends VBoxContainer
class_name TurnHistoryCell
# turn_history_cell.gd
# Create a new turn history cell with the provided information.

# Each cell is 150 Width, 195 Height

const turnHistoryCell = preload("res://scenes/turn_history_cell.tscn")

@onready var label_turn = $Label_grid1
@onready var label_p1money = $Label_grid2/Money_p1
@onready var label_p1steal = $Label_grid2/Steal_p1
@onready var label_p1support = $Label_grid2/Support_p1
@onready var label_p2money = $Label_grid3/Money_p2
@onready var label_p2steal = $Label_grid3/Steal_p2
@onready var label_p2support = $Label_grid3/Support_p2

static func create(turn: int, p1_choice: int, p1_money_earned: int,
					p2_choice: int, p2_money_earned: int):
	var instance = turnHistoryCell.instantiate()
	instance.label_turn.text = str(turn)
	instance.p1steal.visible = p1_choice == 0
	instance.p1support.visible = p1_choice == 1
	instance.label_p1money.text = "+ $" + str(p1_money_earned)
	instance.p2steal.visible = p2_choice == 0
	instance.p2support.visible = p2_choice == 1
	instance.label_p2money.text = "+ $" + str(p2_money_earned)
	return instance
