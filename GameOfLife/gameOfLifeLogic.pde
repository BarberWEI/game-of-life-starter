public class Logic { //<>//
  private final int SPACING;
  private final float DENSITY;
  private int[][] grid ;
  private int[][] cellsLifeTime;
  // set to 5 because I don't want to have too many things being kept by my computer
  private int[][][] pastGrids;

  public Logic(int SPACING, float DENSITY, int[][] grid, int NUMBER_OF_GRIDS_BEING_KEPT) {
    this.SPACING = SPACING;
    this.DENSITY = DENSITY;
    this.grid = grid;
    this.cellsLifeTime = new int[grid.length][grid[0].length];
    pastGrids = new int[NUMBER_OF_GRIDS_BEING_KEPT][][];
    for (int i = 0; i < pastGrids.length; i++) {
      pastGrids[i] = grid;
    }
    getFirstGrid();
  }

  public int[][] getGrid() {
    return grid;
  }

  public void setGrid(int row, int col, int val) {
    grid[row][col] = val;
    cellsLifeTime[row][col] = val;
    keepTrackOfPastGrids();
  }

  public void iterateAndShow() {
    showGrid();
    calcNextGrid();
    keepTrackOfPastGrids();
  }

  private void getFirstGrid() {
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        // initializes the counter for amount of itterations the cells has been alive for
        if (random(1) <= DENSITY) {
          grid[i][j] = 1;
          cellsLifeTime[i][j] = 1;
        } else {
          grid[i][j] = 0;
          cellsLifeTime[i][j] = 0;
        }
      }
    }
  }

  // checks to see if the row/column is out of index
  private boolean cellOutOfBounds(int cellRow, int cellCol) {
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

  private void calcNextGrid() {
    int[][] nextGrid = new int[grid.length][grid[0].length];
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        int valueOfCell = countNeighbors(i, j);
        if ((valueOfCell > 1 && valueOfCell < 4) && grid[i][j] == 1) {
          nextGrid[i][j] = 1;
          cellsLifeTime[i][j]++;
        } else if (valueOfCell == 3) {
          nextGrid[i][j] = 1;
          cellsLifeTime[i][j]++;
        } else {
          nextGrid[i][j] = 0;
          cellsLifeTime[i][j] = 0;
        }
      }
    }
    grid = nextGrid;
  }

  // counts living neighbors in 3X3
  private int countNeighbors(int row, int col) {
    int valueOfCell = 0;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (!cellOutOfBounds(row + i, col + j)) {
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

  private void keepTrackOfPastGrids() {
    for (int i = pastGrids.length - 1; i >= 0; i--) {
      if (i == 0) {
        pastGrids[0] = grid;
      } else {
        pastGrids[i] = pastGrids[i -1];
      }
    }
  }

  public void showGrid() {
    // your code here
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 0) {
          fill(232, 220, 202);
          square(j * SPACING, i * SPACING, SPACING);
        } else {

          // buggy
          int[] colors = colorGenerator(i, j);
          fill(colors[0], colors[1], colors[2]);
          square(j * SPACING, i * SPACING, SPACING);
        }
      }
    }
  }

  public int[] colorGenerator(int row, int col) {
    if (cellsLifeTime[row][col] > 1000) {
      return new int[] {0, 0, 0};
    } else if (cellsLifeTime[row][col] > 500) {
      return new int[] {35, 41, 122};
    } else if (cellsLifeTime[row][col] > 250) {
      return new int[] {0, 72, 186};
    } else if (cellsLifeTime[row][col] > 125) {
      return new int[] {135, 206, 235};
    } else if (cellsLifeTime[row][col] > 62) {
      return new int[] {176, 224, 230};
    } else {
      return new int[] {209, 234, 240};
    }
  }

  public void moveBackwards(int numberOfIterationsPassed) {
    grid = pastGrids[numberOfIterationsPassed];
    showGrid();
  }
}
