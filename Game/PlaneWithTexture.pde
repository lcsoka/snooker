public class PlaneWithTexture extends Plane {
  PImage image=loadImage("assets/hole.png");
  PlaneWithTexture(PVector position, float planeWidth, float planeHeight, PVector planeColor) {
    super(position, planeWidth, planeHeight, planeColor);
  }

  void draw() {

    textureMode(NORMAL);
    pushMatrix();
    beginShape();
    texture(image);
    
    translate(this.position.x, this.position.y, this.position.z);
    vertex(this.planeWidth / 2, 0, this.planeHeight / 2,1,0);
    vertex(this.planeWidth / 2, 0, - this.planeHeight / 2,1,1);
    vertex(- this.planeWidth / 2, 0, - this.planeHeight / 2,0,1);
    vertex(- this.planeWidth / 2, 0, this.planeHeight / 2,0,0);
    endShape(CLOSE);
    popMatrix();
  }
}
