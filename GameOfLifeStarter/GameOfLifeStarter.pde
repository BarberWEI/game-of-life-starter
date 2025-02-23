final int SPACING = 20; //<>//
final float DENSITY = 0.1;
int[][] grid;

void setup() {
  size(1600, 800);
  noStroke();
  frameRate(10);
  grid = new int[height / SPACING][width / SPACING];
  getFirstGrid(grid);
}

void draw() {
  showGrid(grid);
  grid = calcNextGrid(grid);
}

void getFirstGrid(int[][] grid) {
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

boolean cellOutOfBounds(int cellRow, int cellCol, int[][] grid) {
  if (cellRow == grid.length) {
    return true;
  } else if (cellRow == -1) {
    return true;
  } else if (cellCol == grid[cellRow].length) {
    return true;
  } else if (cellCol == -1) {
    return true;
  }
  return false;
}

int[][] calcNextGrid(int[][] grid) {
  int[][] nextGrid = new int[grid.length][grid[0].length];
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      int valueOfCell = countNeighbors(i, j, grid);
      if ((valueOfCell > 1 && valueOfCell < 4) && grid[i][j] == 1) {
        nextGrid[i][j] = 1;
      } else if (valueOfCell == 3) {
        nextGrid[i][j] = 1;
      } else {
        nextGrid[i][j] = 0;
      }
    }
  }
  return nextGrid;
}

int countNeighbors(int row, int col, int[][] grid) {
  int valueOfCell = 0;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (!cellOutOfBounds(row + i, col + j, grid)) {
        boolean isSelf = i == 0 && j == 0;
        boolean isLivingCell = grid[row + i][col + j] == 1;
        if (isLivingCell && !isSelf) {
          valueOfCell++;
        }
      }
    }
  }
  return valueOfCell;
}

void showGrid(int[][] grid) {
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
