# Game of Life

Conway's "Game of Life" is a classic computer science challenge, solved by many students in many languages throughout the years. The best way to learn about it is to play it here: https://playgameoflife.com/

You will use a 2D `int[][]` to represent "cells". Unlike the true game, your version will not be on an infinite plane. You will use a finite Processing canvas to visualize the game.

You are given starter code. You may adjust the canvas and the cell spacing. The `DENSITY` constant should be used to initialize the game grid with roughly that percentage of "living" cells. I.e., if it's set to 0.1 that means that roughly 10% of the cells will be alive at the start. You will randomly populate the cells.

Note that rows are designated by `y` and columns by `x`. If you want to rename these variables you can, but be consistent!

## Regeneration Rules
For a space that is populated (1):
- Each cell with one or no neighbors dies, as if by solitude.
- Each cell with four or more neighbors dies, as if by overpopulation.
- Each cell with two or three neighbors survives.

For a space that is unpopulated (0):
- Each cell with three neighbors becomes populated.
- Otherwise, the cell remains unpopulated.

Of course, checking indexes that are out-of-bounds will throw errors. You can get creative, but you may find that there is no "clean" solution to this. You'll end up with a bunch of if/else statements...




My code does basic logic for the game, can pause, move forward one step at a time when paused, and move back 4 spaces when paused. However, moving back purely depends on what was kept in storage, meaning that when you manually move forward, then backward, then forward, then backward, the the resulting grid would be the third forward. 

Also, you can click on blocks to add to them







### Good luck!