final int SPACING = 20;
final float DENSITY = 0.1;
final int NUMBER_OF_GRIDS_BEING_KEPT = 5;
int[][] grid;
boolean pause = false;
boolean mouseLetGo = false;
int numberOfIterationsPassed = 0;
 

Logic gameOfLife;

void setup() {
  size(1400, 850);
  noStroke();
  frameRate(10);
  grid = new int[height / SPACING][width / SPACING];
  gameOfLife = new Logic(SPACING, DENSITY, grid, NUMBER_OF_GRIDS_BEING_KEPT);
  //gameOfLife.getFirstGrid(grid);
}

void draw() {
  if(!pause) {
    gameOfLife.iterateAndShow();
  } else {
    useMouseToChangeCell();
    gameOfLife.showGrid();
  }
}

void mouseReleased() {
  mouseLetGo = true;
}

void useMouseToChangeCell() {
  if (mousePressed && mouseLetGo) {
    int row = mouseY/SPACING;
    int col = mouseX/SPACING;
    int[][] grid = gameOfLife.getGrid();
    if (grid[row][col] == 0){
      gameOfLife.setGrid(row, col, 1);
    } else {
      gameOfLife.setGrid(row, col, 0);
    }
    mouseLetGo = false;
    // work on here
  }
}

void keyPressed() {
  if (key == ' ') {
    pause = !pause;
    numberOfIterationsPassed = 0;
  } else if (keyCode == RIGHT && pause) {
    gameOfLife.iterateAndShow();
    numberOfIterationsPassed = 0;
  } else if (keyCode == LEFT) {
    if (numberOfIterationsPassed < 4) {
      numberOfIterationsPassed++;
      gameOfLife.moveBackwards(numberOfIterationsPassed);
    }
  }
}
