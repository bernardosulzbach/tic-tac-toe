#!/usr/bin/env bash
#
# Creates a standalone distribution of the game in the ./tic-tac-toe directory.

echo "Creating the executable..."
raco exe game.rkt
echo "Making a standalone distribution..."
raco distribute tic-tac-toe game
rm game
echo "Done!"
