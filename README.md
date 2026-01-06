# BattleScripts

BattleScripts is a game based on the iterated prisoner's dillemma, a thought experiment in regards to if one should act in self interest or mutual benefit. In this game, players can either choose to steal from the other player or support the other player over many turns.

BattleScripts will run on the Lead Mentor's laptop and be played on a big screen. Students will work on their scripts on their own laptops and turn in their .py files to compete.

Students that do this excersize should become more familiar with the concept of functions, returning variables, storing variables, getting data, and conditional statements. They should also gain a better understanding of writing pseudocode, and planning in advance.

## gm_main

gm_main.py is the main game manager. It initiates new games, writes leaderboard information.

The script will need to be able to:

- Load 2 .py files before initiating a match
- Let the user choose if the matches should be recorded or not
- Start matches
- Record the result of matches: Both player names and the money earned from the match
- Return the leaderboard in a nice format
- Allow the user to choose if battles should play out on auto mode or manual mode (Basically, provide delay between turns)
- Provide reset button to reset all data except recorded battles
- Store ENUM with current state of the program menu 


## gm_battle

gm_battle.py is the battle manager. It calls player scripts and manages each turn, returning information to gm_main.

The script will need to be able to:
- Initialize 2 scripts
- Create data structure for each storing their move history, money total, and name
- for (amount of turns in battle),
    - run main of both scripts, and get their choice of move
    - store money total after interaction
    - store both player's choices in queue
    - call gm_main function "turn_delay"
- return both data structures to gm_main

## script_template

script_template.py is a template for the students battlescript that they will submit. It includes some functions and variables by default for them to fill out. The main function is run each turn.

The script will need to be able to:

- Provide an empty main function that returns STEAL or SUPPORT

- Provide variables for:
    - current turn
    - their money
    - my money
    - their recent turns
    - my recent turns

- Provide function for updating all variables