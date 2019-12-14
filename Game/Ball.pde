public class Ball { //<>//
  private PShape shape;
  private PVector position = new PVector(0, 0, 0); 
  private PVector ballColor = new PVector(255, 255, 255);
  private PVector direction = new PVector(1, 0, 0); // ALWAYS UNIT VECTOR
  private PVector velocity = new PVector(0, 0, 0);
  private PVector acceleration = new PVector(0, 0, 0);
  private float radius = 10;
  private PShape ball;
  private int t = millis();
  private float m = 10;
  private float force = 10;
  private float rotation = 0;
  private float speed = 0;
  private float friction = 0.005;
  //private float friction = 0;
  private float slowDownFactor = 1-friction;

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
    shape = createShape(SPHERE, radius); 
    shape.setStroke(false);
    shape.setFill(color(ballColor.x, ballColor.y, ballColor.z));
  }

  void update() {
    int dT = millis() - t;
    t = millis();

    if (speed > 0.005) {
      speed = Math.max(0, speed - speed * friction);
    } else {
      speed = 0;
    }
    this.velocity = this.velocity.copy().mult(slowDownFactor);

    if (this.velocity.mag() > 0.05) {
      this.position.add(this.velocity);
    } else {
      this.velocity = new PVector(0, 0, 0);
    }
    //float force = GRAVITY * this.mass;

    //this.direction.x = this.direction.x * cos(rotation) - this.direction.z*sin(rotation);
    //this.direction.z = -this.direction.x * sin(rotation) + this.direction.z*cos(rotation);
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
    speed = speed - speed*(percent /100);
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
    stroke(255, 255, 0);
    PVector dir = direction.copy().mult(20);
    line(0, 0, 0, dir.x, dir.y, dir.z);
    fill(ballColor.x, ballColor.y, ballColor.z);
    shape(shape);
    popMatrix();
  }

  public void stop() {
    this.speed = 0;
  }

  public void shoot() {
    println("shoot");
    int dT = millis() - t;
    t = millis();
    float force = 5;
    this.velocity = this.velocity.add(this.direction.normalize().copy().mult(force));
  }
}
