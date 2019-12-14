public class PoolTable {

  private PVector position = new PVector(0, 0, 0);
  private PVector poolSize = new PVector(1000, 500);
  private Plane plane;
  private float holeSize = 30;
  private float borderWidth = 50;
  private float legRadius = 25;
  private float legHeight = 200;
  private ArrayList<Border> borders = new ArrayList<Border>();
  private ArrayList<Cylinder> legs = new ArrayList<Cylinder>();
  private ArrayList<Plane> holes = new ArrayList<Plane>();

  PoolTable() {
    createTable();
  }

  void createTable() {

    float x = this.position.x + this.poolSize.x / 2;
    float y = position.y;
    float z = this.position.z + this.poolSize.y / 2;
    float w = borderWidth;

    // Table top
    plane = new Plane(poolSize.x, poolSize.y);

    // Holes
    PVector holeColor = new PVector(0, 0, 0);
    float holeY = y - 0.1;
    Plane topLeftHole = new PlaneWithTexture(new PVector(-x+holeSize/2, holeY, -z+holeSize/2), holeSize, holeSize, holeColor); 
    Plane topCenterHole = new PlaneWithTexture(new PVector(0, holeY, -z+holeSize/2), holeSize, holeSize, holeColor); 
    Plane topRightHole = new PlaneWithTexture(new PVector(x-holeSize/2, holeY, -z+holeSize/2), holeSize, holeSize, holeColor);
    Plane bottomLeftHole = new PlaneWithTexture(new PVector(-x+holeSize/2, holeY, z-holeSize/2), holeSize, holeSize, holeColor); 
    Plane bottomCenterHole = new PlaneWithTexture(new PVector(0, holeY, z-holeSize/2), holeSize, holeSize, holeColor); 
    Plane bottomRightHole = new PlaneWithTexture(new PVector(x-holeSize/2, holeY, z-holeSize/2), holeSize, holeSize, holeColor);
    this.holes.add(topLeftHole);
    this.holes.add(topCenterHole);
    this.holes.add(topRightHole);
    this.holes.add(bottomLeftHole);
    this.holes.add(bottomCenterHole);
    this.holes.add(bottomRightHole);
    // Borders
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

    // Legs
    Cylinder topLeftLeg = new Cylinder(new PVector(-x-w + legRadius, y, -z-w+legRadius), legRadius, legHeight);
    Cylinder topRightLeg = new Cylinder(new PVector(x+w - legRadius, y, -z-w+legRadius), legRadius, legHeight);
    Cylinder bottomLeftLeg = new Cylinder(new PVector(-x-w + legRadius, y, z+w-legRadius), legRadius, legHeight);
    Cylinder bottomRightLeg = new Cylinder(new PVector(x+w - legRadius, y, z+w-legRadius), legRadius, legHeight);

    legs.add(topLeftLeg);
    legs.add(topRightLeg);
    legs.add(bottomLeftLeg);
    legs.add(bottomRightLeg);
  }

  void update() {
  }

  void draw() {
    noStroke();
    lights();
    // Plane
    plane.draw();

    // Legs
    for (Plane h : holes) {
      h.draw();
    }

    // Borders
    for (Border b : borders) {
      b.draw();
    }

    // Legs
    for (Cylinder l : legs) {
      l.draw();
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

  public float getWidth() {
    return this.poolSize.x;
  }


  public float getHeight() {
    return this.poolSize.y;
  }

  public PVector getPosition() {
    return this.position;
  }
}
