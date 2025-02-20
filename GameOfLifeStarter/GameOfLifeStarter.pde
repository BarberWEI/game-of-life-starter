final int SPACING = 20; //<>//
final float DENSITY = 0.1;
int[][] grid;

void setup() {
  size(800, 600);
  noStroke();
  frameRate(10);
  grid = new int[height / SPACING][width / SPACING];
  getFirstGrid();
}

void draw() {
  showGrid();
  grid = calcNextGrid();
}

void getFirstGrid() {
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      if (random(1) <= DENSITY) {
        grid[i][j] = 1;
      } else {
        grid[i][j] = 0;
      }
    }
  }
}

boolean cellOutOfBounds(int cellRow, int cellCol) {
  if (cellRow == grid.length) {
    return false;
  } else if (cellRow == -1) {
    return false;
  } else if (cellCol == grid.length) {
    return false;
  } else if (cellCol == -1) {
    return false;
  }
  return true;
}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      int valueOfCell = calcOneNextCell(i, j);
      if (valueOfCell > 1 && valueOfCell < 4) {
        nextGrid[i][j] = 1;
      } else {
        nextGrid[i][j] = 0;
      }
    }
  }
  return nextGrid;
}

int calcOneNextCell(int row, int col) {
  int valueOfCell = 0;
  for (int i = -1; i < -2; i++) {
    for (int j = -1; j < -2; j++) {
      if (!cellOutOfBounds(row + i, col + j) && grid[row][col] == 1) {
        valueOfCell++;
      }
    }
  }
  return valueOfCell;
}

int countNeighbors(int y, int x) {
  int n = 0; // don't count yourself!

  return n;
}

void showGrid() {
  // your code here
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      if (grid[i][j] == 0) {
        fill(0);
        square(j * SPACING, i * SPACING, SPACING);
      } else {
        fill(255, 0, 0);
        square(j * SPACING, i * SPACING, SPACING);
      }
    }
  }
}
