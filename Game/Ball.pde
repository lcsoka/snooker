public class Ball { //<>//
  private PShape shape;
  private PVector position = new PVector(0, 0, 0); 
  private PVector ballColor = new PVector(255, 255, 255);
  private PVector direction = new PVector(1, 0, 0); // ALWAYS UNIT VECTOR
  private PVector velocity = new PVector(0, 0, 0); 
  private float radius = BALL_RADIUS;
  private float t = millis();
  private float speed = 0;
  private float friction = 0.01;
  private float slowDownFactor = 1-friction;
  private float force = 0;

  Ball() {
    this.initializeShape();
  }

  Ball(PVector position) {
    this.position = position;
    this.initializeShape();
  }

  Ball(PVector position, PVector bColor) {
    this.position = position;
    this.ballColor = bColor;
    this.initializeShape();
  }

  private void initializeShape() {
    shape = createShape(SPHERE, radius); 
    shape.setStroke(false);
    shape.setFill(color(ballColor.x, ballColor.y, ballColor.z));
    this.rotate(0.01);
  }

  void update() {
    float dT = (millis() - t) / 10.0f;
    t = millis();

    //    if (speed > 0.005) {
    //      speed = Math.max(0, speed - speed * friction);
    //    } else {
    //      speed = 0;
    //    }

    this.velocity = this.velocity.copy().mult(slowDownFactor);

    if (this.velocity.mag() > 0.005) {
      this.position.add(this.velocity.copy().mult(dT));
    } else {
      this.velocity = new PVector(0, 0, 0);
    }

    if (this.velocity.mag() > 0 ) {
      this.direction = this.velocity.copy().normalize();
    }
  }

  PVector getPosition() {
    return this.position;
  }

  void setPosition(PVector pos) {
    this.position = pos;
  }

  PVector getDirection() {
    return this.direction;
  }

  void setDirection(PVector dir) {
    this.direction = dir;
  }

  PVector getVelocity() {
    return this.velocity;
  }

  void setVelocity(PVector vel) {
    this.velocity = vel;
  }

  float getRadius() {
    return this.radius;
  }

  float getSpeed() {
    return this.speed;
  }

  void setSpeed(float speed) {
    this.speed = speed;
  }

  void setColor(PVector c) {
    this.ballColor = c;
    shape.setFill(color(ballColor.x, ballColor.y, ballColor.z));
  }

  void loseSpeed(float percent) {
    this.velocity.mult(1 - percent/100.0);
  }

  void rotate(float alpha) {
    float x = this.direction.x;
    float y = this.direction.y;
    float z = this.direction.z;

    float cosa = cos(alpha);
    float sina = sin(alpha);

    z = cosa * z - sina * x;
    x = cosa * x + sina * this.direction.z;

    this.direction.x = x;
    this.direction.y = y;
    this.direction.z = z;
  }

  void draw() {
    //noStroke();
    lights();
    pushMatrix();
    translate(position.x, position.y, position.z);
    if (DEBUG) {
      stroke(255, 255, 0);
      PVector dir = direction.copy().mult(20);
      line(0, 0, 0, dir.x, dir.y, dir.z);
    }
    shape(shape);
    popMatrix();
  }

  public void stop() {
    this.speed = 0;
  }

  public void setForce(float force) {
    this.force = force;
  }

  public void shoot() {
    println("shoot");

    this.velocity = this.velocity.add(this.direction.normalize().copy().mult(force));
  }
}
