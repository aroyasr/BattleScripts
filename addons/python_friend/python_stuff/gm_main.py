# gm_main.py
# This script is initialised by the Godot game whenever a match begins. it handles 1 match between 2 python scripts.
# It also provides methods for retrieving match stats, initializing to default state, updating leaderboard,
# Reading & retrieving leaderboard, changing match settings/vars.

# Author: AROHA KIRI
# 2026
# Tuhura Tech

import importlib.util
from pathlib import Path

# Constants
STEAL = 0
SUPPORT = 1

class PlayerWrapper:
    """Loads a student script and manages its state."""

    def __init__(self, filepath):
        self.filepath = Path(filepath)
        self.module = self._load_module(self.filepath)

        # Persistent state for this player
        self.money = 0
        self.move_history = []
        self.last_move = None

    def _load_module(self, path):
        """Dynamically import a student script as a module."""
        module_name = path.stem
        spec = importlib.util.spec_from_file_location(module_name, path)
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        return module

    def run_turn(self, opponent_money, turn_number, opponent_last_move):
        """
        Calls the student's main() function.
        The student's update() will modify their internal variables.
        """
        move = self.module.main(
            self.money,
            opponent_money,
            turn_number,
            self.last_move,
            opponent_last_move
        )

        # Validate move
        if move not in (STEAL, SUPPORT):
            raise ValueError(
                f"Invalid move returned by {self.filepath.name}: {move}"
            )

        # Update internal state
        self.last_move = move
        self.move_history.append(move)

        return move


class GameManager:
    """Runs a full BattleScripts match."""

    def __init__(self, p1_path, p2_path, starting_money=10, total_turns=10):
        self.turn = 0
        self.total_turns = total_turns

        # Load players
        self.p1 = PlayerWrapper(p1_path)
        self.p2 = PlayerWrapper(p2_path)

        # Starting money
        self.p1.money = starting_money
        self.p2.money = starting_money

    def resolve_turn(self, p1_move, p2_move):
        """
        Apply game rules to update money.
        You can customize this however your game works.
        """

        # payoff matrix:
        # SUPPORT/SUPPORT → both +2
        # STEAL/SUPPORT   → stealer +3, supporter +0
        # SUPPORT/STEAL   → stealer +3, supporter +0
        # STEAL/STEAL     → both 1

        if p1_move == SUPPORT and p2_move == SUPPORT:
            self.p1.money += 2
            self.p2.money += 2

        elif p1_move == STEAL and p2_move == SUPPORT:
            self.p1.money += 3

        elif p1_move == SUPPORT and p2_move == STEAL:
            self.p2.money += 3

        elif p1_move == STEAL and p2_move == STEAL:
            self.p1.money += 1
            self.p2.money += 1

    def main(self):
        """
        Runs one turn of the game.
        Returns True when the match is finished.
        """

        if self.turn > self.total_turns:
            return True  # match already finished

        self.turn += 1

        # Get moves from each player
        p1_move = self.p1.run_turn(
            opponent_money=self.p2.money,
            turn_number=self.turn,
            opponent_last_move=self.p2.last_move
        )

        p2_move = self.p2.run_turn(
            opponent_money=self.p1.money,
            turn_number=self.turn,
            opponent_last_move=self.p1.last_move
        )

        # Apply game rules
        self.resolve_turn(p1_move, p2_move)

        # Return False → match continues
        return self.turn >= self.total_turns

    def get_state(self):
        return {
            "turn": self.turn,
            "p1_money": self.p1.money,
            "p2_money": self.p2.money,
            "p1_last_move": self.p1.last_move,
            "p2_last_move": self.p2.last_move,
            "p1_history": self.p1.move_history,
            "p2_history": self.p2.move_history,
        }

