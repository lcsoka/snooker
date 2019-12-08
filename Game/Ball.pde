public class Ball {
  private PVector position = new PVector(0, 0, 0); 
  private PVector ballColor = new PVector(255,255,255);
  private PVector velocity = new PVector();
  private float radius = 10;
  private PShape ball;
  
  Ball() {
   this.initializeShape();
  }
  
  Ball(PVector position) {
    this.position = position;
    this.initializeShape();
  }

  Ball(PVector position, float radius) {
    this.position = position;
    this.radius = radius;
    this.initializeShape();
  }
  
  private void initializeShape() {
    ball = createShape(SPHERE, radius); 
    ball.setStroke(false);
  }
  
  void update() {
  }
  
  void draw() {
    noStroke();
    lights();
    fill(255);
    pushMatrix();
    translate(position.x,position.y,position.z);
    shape(ball);
    popMatrix();
  }
}
