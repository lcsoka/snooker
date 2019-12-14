import peasy.*;
int planeSize = 500;
public class PoolGame {
  Camera camera;
  PeasyCam cam;
  PoolTable table;
  Ball cueBall;
  private ArrayList<Ball> balls = new ArrayList<Ball>();


  PoolGame(Game g) {
    camera = new Camera();
    //cam = new PeasyCam(g, 1000);
    table = new PoolTable();
    cueBall = new Ball(new PVector(0, -10, 0));
    balls.add(cueBall);
    // Test
    Ball ball = new Ball(new PVector(100, -10, 10));
    ball.setColor(new PVector(192, 0, 0));

    balls.add(ball);
    //balls.add(new Ball(new PVector(250, -10, 0)));
  }

  public void draw() {
    background(158, 228, 255);
    update();

    table.draw();
    cueBall.draw();
    for (Ball b : balls) {
      b.draw();
    }
  }

  void update() {
    camera.update();

    // Collisions
    for (Ball b : balls) {
      checkBallWallCollision(b, table);
    }
    checkBallCollision(cueBall, balls.get(1));

    table.update();
    cueBall.update();

    for (Ball b : balls) {
      b.update();
    }
  }


  void checkBallWallCollision(Ball b, PoolTable table) {
    float topZ = table.getPosition().z - table.getHeight() / 2;
    float bottomZ = table.getPosition().z + table.getHeight() / 2;
    float leftX = table.getPosition().x - table.getWidth() / 2;
    float rightX = table.getPosition().x + table.getWidth() / 2;
    float r = b.getRadius();
    PVector bPos = b.getPosition();
    PVector ballDir = b.getVelocity();

    // Touched right wall
    if (bPos.x + r > rightX) {
      if (ballDir.x > 0) {
        ballDir.x *= -1;
        b.loseSpeed(3);
      }
    }

    // Touched left wall
    if (bPos.x - r < leftX) {
      if (ballDir.x < 0) {
        ballDir.x *= -1;
        b.loseSpeed(3);
      }
    }

    // Touched top wall
    if (bPos.z - r < topZ) {
      if (ballDir.z < 0) {
        ballDir.z *= -1;
        b.loseSpeed(3);
      }
    }  
    // Touched bottom wall
    if (bPos.z + r > bottomZ) {
      if (ballDir.z > 0) {
        ballDir.z *= -1;
        b.loseSpeed(3);
      }
    }
  }

  void checkBallCollision(Ball b1, Ball b2) {

    PVector a = b1.getPosition().copy();
    PVector b = b2.getPosition().copy();

    PVector x1 = new PVector(b1.getPosition().x, b1.getPosition().z);
    PVector x2 = new PVector(b2.getPosition().x, b2.getPosition().z);
    float ar = b1.getRadius();
    float br = b2.getRadius();
    PVector v1 = new PVector(b1.getVelocity().x, b1.getVelocity().z);
    PVector v2 = new PVector(b2.getVelocity().x, b2.getVelocity().z);

    //  // Two circles are intersecting

    if (Math.pow(a.x-b.x, 2) + Math.pow(a.y-b.y, 2) + Math.pow(a.z-b.z, 2) < Math.pow(ar+br, 2)) {
      println("collide");
      // Set position to exactly one radius away
      PVector tempPos, correctPos;

      //b1.setVelocity(new PVector(0, 0, 0));
      //b2.setVelocity(new PVector(0, 0, 0));
      //if (v1.mag() > v2.mag()) {

        PVector dif = x2.copy().sub(x1);
        tempPos = x2.add(dif.copy().normalize().mult(-1*ar*2));
        correctPos = new PVector(tempPos.x, a.y, tempPos.y );
        b1.setPosition(correctPos);
      //} else {
      //  tempPos = x2.add(v2.copy().normalize().mult(-1*br*2));
      //  correctPos = new PVector(tempPos.x, b.y, tempPos.z);
      //  b2.setPosition(correctPos);
      //}




      float c = (v1.copy().sub(v2).dot(x1.copy().sub(x2))) / ((x1.copy().sub(x2)).mag() * (x1.copy().sub(x2)).mag());
      PVector b1Pos = v1.copy().sub(x1.copy().sub(x2).mult(c));
      float d = (v2.copy().sub(v1).dot(x2.copy().sub(x1))) / ((x2.copy().sub(x1)).mag() * (x2.copy().sub(x1)).mag());
      PVector b2Pos = v2.copy().sub(x2.copy().sub(x1).mult(d));

      PVector newVel1 = new PVector(b1Pos.x, 0, b1Pos.y);
      PVector newVel2 = new PVector(b2Pos.x, 0, b2Pos.y);
      b1.setVelocity(newVel1);
      b2.setVelocity(newVel2);
    }
  }

  public void keyPressed() {
    if (key == 'w') {
      camera.moveForward(true);
    } else if (key == 's') {
      camera.moveBackward(true);
    } else if (key == 'a') {
      camera.moveLeft(true);
    } else if (key == 'd') {
      camera.moveRight(true);
    } else if (key == 'p') {
      cueBall.setSpeed(2);
      cueBall.shoot();
    }
  }

  public void keyReleased() {
    if (key == 'w') {
      camera.moveForward(false);
    } else if (key == 's') {
      camera.moveBackward(false);
    } else if (key == 'a') {
      camera.moveLeft(false);
    } else if (key == 'd') {
      camera.moveRight(false);
    }
  }

  public void mouseClicked() {
  }
}
