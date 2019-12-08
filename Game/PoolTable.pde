public class PoolTable {

  private PVector position = new PVector(0, 0, 0);
  private PVector poolSize = new PVector(1000, 500);
  private Plane plane;
  private int borderWidth = 50;
  private ArrayList<Border> borders = new ArrayList<Border>();

  PoolTable() {
    createTable();
  }

  void createTable() {

    float x = this.position.x + this.poolSize.x / 2;
    float y = position.y;
    float z = this.position.z + this.poolSize.y / 2;
    int w = borderWidth;

    plane = new Plane(poolSize.x, poolSize.y);

    Border topBorder = new Border(
      new PVector(-x-w, y, -z-w), 
      new PVector(x+w, y, -z-w), 
      new PVector(x+w, y, -z), 
      new PVector(-x-w, y, -z));
    Border bottomBorder = new Border(
      new PVector(-x-w, y, z), 
      new PVector(x+w, y, z), 
      new PVector(x+w, y, z+w), 
      new PVector(-x-w, y, z+w));
    Border leftBorder = new Border(
      new PVector(-x-w, y, -z), 
      new PVector(-x, y, -z), 
      new PVector(-x, y, z), 
      new PVector(-x-w, y, z));
    Border rightBorder = new Border(
      new PVector(x+w, y, -z), 
      new PVector(x, y, -z), 
      new PVector(x, y, z), 
      new PVector(x+w, y, z));

    borders.add(topBorder);
    borders.add(bottomBorder);
    borders.add(leftBorder);
    borders.add(rightBorder);
  }

  void update() {
  }

  void draw() {
    noStroke();

    // Plane
    plane.draw();

    // Borders
    for (Border b : borders) {
      b.draw();
    }


    if (DEBUG) {
      //X  - red
      stroke(192, 0, 0);
      line(0, 0, 0, planeSize, 0, 0);
      //Y - green
      stroke(0, 192, 0);
      line(0, 0, 0, 0, planeSize, 0);
      //Z - blue
      stroke(0, 0, 192);
      line(0, 0, 0, 0, 0, planeSize);
    }
  }
}
