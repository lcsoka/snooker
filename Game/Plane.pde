public class Plane {
  protected PVector position = new PVector(0, 0, 0);
  protected PVector planeColor = new PVector(0, 155, 0);
  protected float planeWidth = 500;
  float planeHeight = 500;

  Plane(float size) {
    this.planeWidth = size;
    this.planeHeight = size;
  }

  Plane(float planeWidth, float planeHeight) {
    this.planeWidth = planeWidth;
    this.planeHeight = planeHeight;
  }

  Plane(PVector position, float planeWidth, float planeHeight) {
    this.position = position;
    this.planeWidth = planeWidth;
    this.planeHeight = planeHeight;
  }

  Plane(PVector position, float planeWidth, float planeHeight, PVector planeColor) {
    this.position = position;
    this.planeWidth = planeWidth;
    this.planeHeight = planeHeight;
    this.planeColor = planeColor;
  }

  void update() {
  }

  void draw() {

    fill(planeColor.x, planeColor.y, planeColor.z);
    pushMatrix();
    beginShape();
    this.createShape();
    endShape(CLOSE);
    popMatrix();
  }

  void createShape() {
    translate(this.position.x, this.position.y, this.position.z);
    vertex(this.planeWidth / 2, 0, this.planeHeight / 2);
    vertex(this.planeWidth / 2, 0, - this.planeHeight / 2);
    vertex(- this.planeWidth / 2, 0, - this.planeHeight / 2);
    vertex(- this.planeWidth / 2, 0, this.planeHeight / 2);
  }
}
