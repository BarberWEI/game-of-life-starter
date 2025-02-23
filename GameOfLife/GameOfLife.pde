final int SPACING = 20;
final float DENSITY = 0.1;
int[][] grid;
boolean pause = false;

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
    if (mousePressed) {
      int x = mouseX;
      int y = mouseY;
      gameOfLife.setGrid(y/SPACING, x/SPACING, 1);
      gameOfLife.showGrid();
      System.out.println(x/SPACING);
      // work on here
    }
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
