########################
## script_template.py ##
########################
# Hello student!
# Welcome to BattleScripts! This is the file template for your script that you will submit as your BattleScript.


# Your script will decide what to do each turn. It's up to you to come up with a strategy, think about how to 
# write it in code, and write the code. Go through the task list to begin.

""" TASK LIST: (Put X inside square brackets once you have completed the task.)
- Plan out your strategy on paper []
- Write your pseudocode on paper []
- Rename this file []
- Change the NAME constant []
- Ensure that the main function always returns STEAL or SUPPORT []
"""



# Constants 
NAME = "" 
STEAL = 0       # Don't change these numbers...
SUPPORT = 1     # Unless you like ugly code and confusing yourself!

# Variables (Do not modify)
my_money          #How much money your script currently has in the match
their_money       #How much money the other script currently has in the match

last_turn         #The number of the most recent turn. Using my_move_history[current_turn] will give you the move you made last turn.

my_move_history = []        #Array containing your previous moves
their_move_history = []     #Array containing the other script's previous moves


### Custom Variables (Insert your variables here)
meaning_of_life = 42


#### Main Function (Write your code here) ##########################################
# This is the code that runs every turn to decide what to do.
# This function MUST return STEAL or return SUPPORT. Otherwise an error will occur.
####################################################################################

def steal_or_support():
    #This is example code; if this script has no money, it will STEAL. If this script
    #has any money, it will SUPPORT. It's a very simple script; there's better strategies.
    #You can safely delete these comments and the code inside the main function.
    if my_money > 0:
        return SUPPORT
    else:
        return STEAL





###########    DO NOT TOUCH ANY CODE BELOW THIS POINT!    ###########
###########    DO NOT TOUCH ANY CODE BELOW THIS POINT!    ###########
###########    DO NOT TOUCH ANY CODE BELOW THIS POINT!    ###########
###########    DO NOT TOUCH ANY CODE BELOW THIS POINT!    ###########
###########    DO NOT TOUCH ANY CODE BELOW THIS POINT!    ###########
###########    DO NOT TOUCH ANY CODE BELOW THIS POINT!    ###########
###########    DO NOT TOUCH ANY CODE BELOW THIS POINT!    ###########
###########    DO NOT TOUCH ANY CODE BELOW THIS POINT!    ###########

def update(thismoney, theirmoney, currentturn, thisrecentturn, theirrecentturn):
    ''' Update all variables to be up to date with the current game state'''
    my_money = thismoney
    their_money = theirmoney
    current_turn = currentturn
    my_move_history.append(thisrecentturn)
    their_move_history.append(theirrecentturn)

def main(thismoney, theirmoney, currentturn, thisrecentturn, theirrecentturn):
    '''Manages this script. Run each turn.'''
    update(thismoney, theirmoney, currentturn, thisrecentturn, theirrecentturn)
    result = steal_or_support()
    return result