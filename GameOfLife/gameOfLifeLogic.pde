public class logic {
  private final int SPACING;
  private final float DENSITY;
  private int[][] grid ;
  private int[][] cellsLifeTime;
  // set to 5 because I don't want to have too many things being kept by my computer
  private int[][][] pastGrids;

  public logic(int SPACING, float DENSITY, int[][] grid, int NUMBER_OF_GRIDS_BEING_KEPT) {
    this.SPACING = SPACING;
    this.DENSITY = DENSITY;
    this.grid = grid;
    this.cellsLifeTime = grid;
    pastGrids = new int[5][][];
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
    gameOfLife.calcNextGrid();
    keepTrackOfPastGrids();
  }
  
  private void getFirstGrid() {
    for (int i = 0; i < grid.length; i++) { //<>//
      for (int j = 0; j < grid[i].length; j++) {
        // initializes the counter for amount of itterations the cells has been alive for
        cellsLifeTime[i][j] = 0;
        if (random(1) <= DENSITY) {
          grid[i][j] = 1;
        } else {
          grid[i][j] = 0;
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
        } else if (valueOfCell == 3) {
          nextGrid[i][j] = 1;
        } else {
          nextGrid[i][j] = 0;
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
          cellsLifeTime[i][j] = 0;
          fill(232, 220, 202);
          square(j * SPACING, i * SPACING, SPACING);
        } else {
          
          // buggy
          cellsLifeTime[i][j] ++;
          //int[] colors = colorGenerator(i, j);
         
          fill(35, 41, 122);
          square(j * SPACING, i * SPACING, SPACING);
        }
      }
    }
  }
  
  //public int[] colorGenerator(int row, int col) {
  //  if (cellsLifeTime[row][col] > 500) {
  //    int[] colors = {35, 41, 122};
  //    return colors;
  //  } else if (cellsLifeTime[row][col] > 250) {
  //    int[] colors = {0, 72, 186};
  //    return colors;
  //  } else if (cellsLifeTime[row][col] > 100) {
  //    int[] colors = {176, 224, 230};
  //    return colors;
  //  } else if (cellsLifeTime[row][col] > 25) {
  //    int[] colors = {135, 206, 235};
  //    return colors;
  //  } else {
  //    int[] colors = {209, 234, 240};
  //    return colors;
  //  }
  //}
  
  public void moveBackwards(int numberOfIterationsPassed) {
    grid = pastGrids[numberOfIterationsPassed];
    showGrid();
  }
}
