final int SPACING = 20;
final float DENSITY = 0.1;
int[][] grid;

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
  gameOfLife.iterateAndShow();
}
