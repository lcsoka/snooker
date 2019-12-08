public class Plane {
  private PVector position = new PVector(0, 0, 0);
  private float width = 500;
  private float height = 500;

  Plane(float size) {
    this.width = size;
    this.height = size;
  }

  Plane(float planeWidth, float planeHeight) {
    this.width = planeWidth;
    this.height = planeHeight;
  }

  void update() {
  }

  void draw() {

    float x = this.position.x + this.width / 2;
    float z = this.position.z + this.height / 2;

    // Table top
    fill(0, 155, 0);
    beginShape();
    vertex(x, 0, z);
    vertex(x, 0, -(z));
    vertex(-(x), 0, -(z));
    vertex(-(x), 0, z);
    endShape(CLOSE);
  }
}
