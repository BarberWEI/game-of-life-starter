final int SPACING = 20;
final float DENSITY = 0.1;
int[][] grid;
boolean pause = false;
boolean mouseLetGo = false;
int numberOfIterationsPassed = 0;

logic gameOfLife;

void setup() {
  size(1400, 850);
  noStroke();
  frameRate(10);
  grid = new int[height / SPACING][width / SPACING];
  gameOfLife = new logic(SPACING, DENSITY, grid);
  //gameOfLife.getFirstGrid(grid);
}

void draw() {
  if(!pause) {
    gameOfLife.iterateAndShow();
  } else {
    useMouseToChangeCell();
  }
}

void mouseReleased() {
  mouseLetGo = true;
}

void useMouseToChangeCell() {
  if (mousePressed && mouseLetGo) {
      int row = mouseY/SPACING;
      int col = mouseX/SPACING;
      if (gameOfLife.getGrid()[row][col] == 0){
        gameOfLife.setGrid(row, col, 1);
      } else {
        gameOfLife.setGrid(row, col, 0);
      }
      mouseLetGo = false;
      gameOfLife.showGrid();
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
