public class logic {
private final int SPACING;
private final float DENSITY;
private int[][] grid ;

  public logic(int SPACING, float DENSITY, int[][] grid) {
    this.SPACING = SPACING;
    this.DENSITY = DENSITY;
    this.grid = grid;
    getFirstGrid();
  }
    
  public void iterateAndShow() {
    showGrid();
    gameOfLife.calcNextGrid();
  }
  
  private void getFirstGrid() {
    for (int i = 0; i < grid.length; i++) { //<>//
      for (int j = 0; j < grid[i].length; j++) {
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
  
  private void showGrid() {
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
}
