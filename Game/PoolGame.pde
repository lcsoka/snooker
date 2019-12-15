
int planeSize = 500;
public class PoolGame {
  Camera camera;
  CatmullRom spline = new CatmullRom();
  PoolTable table;
  Ball cueBall;
  Cue cue;
  private ArrayList<Ball> balls = new ArrayList<Ball>();
  Cone circle;
  float t;
  float shootTime;
  float cameraT = 1.0;
  float idleStartTime = 0;
  float rotationSpeed = 0.05;
  float cueChangeSpeed = 1;
  boolean isRightPressed = false;
  boolean isLeftPressed = false;
  boolean isUpPressed = false;
  boolean isDownPressed = false;
  boolean hasMovingBall = false;
  boolean shooting = false;
  boolean shootStarted = false;
  int cameraMode = 3;

  PoolGame(Game g) {
    camera = new Camera();
    //cam = new PeasyCam(g, 1000);
    table = new PoolTable();
    cueBall = new Ball(new PVector(-200, -10, 0));
    balls.add(cueBall);
    // Test

    generateBalls(new PVector(200, -10, 0));

    cue = new Cue(new PVector(0, 0, 0), cueBall);

    PVector p1 = new PVector(3, 0.8, 3).mult(200);
    PVector p2 = new PVector(3, -0.4, -3).mult(200);
    PVector p3 = new PVector(-3, 0.8, -3).mult(200);
    PVector p4 = new PVector(-3, -0.2, 3).mult(200);

    PVector boatPos = new PVector(0, -500, 0);

    spline.AddControllPoint(boatPos.copy().add(p1));
    spline.AddControllPoint(boatPos.copy().add(p2));
    spline.AddControllPoint(boatPos.copy().add(p3));
    spline.AddControllPoint(boatPos.copy().add(p4));
    spline.AddControllPoint(boatPos.copy().add(p1));
    spline.AddControllPoint(boatPos.copy().add(p2));
    spline.AddControllPoint(boatPos.copy().add(p3));
  }

  void generateBalls(PVector loc) {
    // Generate vectors used for moving when placing the balls
    float theta = 1f / 6f * PI; // 30º
    PVector rightUp = new PVector(cos(theta), 0, sin(theta));
    rightUp.mult(BALL_RADIUS * 2);

    PVector rightDown = new PVector(cos(theta), 0, -sin(theta));
    rightDown.mult(BALL_RADIUS * 2);

    for (int i = 0; i < 5; i++) { // Going up
      for (int j = 0; j < 5 - i; j++) { // Going down
        PVector ijLoc = rightUp.copy().mult(i).add(rightDown.copy().mult(j));
        PVector ballLoc = loc.copy().add(ijLoc);
        balls.add(new Ball(ballLoc, new PVector(random(255), random(255), random(255))));
      }
    }
  }

  public void draw() {
    background(158, 228, 255);
    update();

    table.draw();
    cue.draw();
    for (Ball b : balls) {
      b.draw();
    }
    drawGUI();
  }

  void update() {
    float dT = (millis() - t) / 10.0f;
    t = millis();
    if (cameraMode == 1) {
      camera.update();
    } else if(cameraMode == 2) {
      cameraT += 0.4 * dT / 100.0f;

      if (cameraT > spline.bases.size() -2) {
        cameraT = 1.0;
      }    
      int idx = (int)cameraT - 1;    
      float t = cameraT - (int)cameraT + 1;

      PVector cameraPos = spline.Eval(idx, t);

      camera.eye = cameraPos;
      camera.at = cueBall.getPosition().copy().add(0, -2, 0);    

      camera.applyCamera();
    } else if(cameraMode == 3) {
      camera.eye = cueBall.getPosition().copy().add(0,-50,0).sub(cueBall.getDirection().copy().mult(200));
      camera.at = cueBall.getPosition().copy().add(0, 50, 0);    
      camera.applyCamera();
    }

    // Collisions
    for (Ball b : balls) {
      checkBallWallCollision(b, table);
    }

    for (int i = 0; i < balls.size(); i++) {
      for (int j = i; j < balls.size(); j++) {
        if (balls.get(i) != balls.get(j)) {
          checkBallCollision(balls.get(i), balls.get(j));
        }
      }
    }

    table.update();
    cue.update();


    hasMovingBall = false;
    for (Ball b : balls) {
      b.update();
      if (b.getVelocity().mag() > 0 ) {
        hasMovingBall = true;
      }
    }

    this.cue.setVisibility( !hasMovingBall);

    if (!hasMovingBall) {
      cameraMode = 3;
      // Cue rotation
      if (this.isRightPressed) {
        this.cueBall.rotate(rotationSpeed);
      }

      if (this.isLeftPressed) {
        this.cueBall.rotate(-rotationSpeed);
      }

      if (this.isUpPressed) {
        this.cue.changeDistance(-cueChangeSpeed);
      }

      if (this.isDownPressed) {
        this.cue.changeDistance(cueChangeSpeed);
      }

      if (this.idleStartTime == 0) {
        this.idleStartTime = millis();
      }
    } else {
      cameraMode = 2;
      this.idleStartTime = 0;
    }

    //Animating shoot
    if (this.shooting) {
      float diff = millis() - shootTime;

      if (!this.shootStarted) {
        cueChangeSpeed = -1 * this.cue.getCueDistance() / 50 * dT;
        this.shootStarted = true;
      } else {
        this.cue.changeDistance(cueChangeSpeed);
      }

      if (diff > 500) {
        this.shooting = false;
        this.shootStarted = false;
        cueChangeSpeed = 1;
        this.shoot();
        this.cue.setDistance(this.cue.getMaxDistance());
      }
    }

    if (this.idleStartTime > 0 && !this.hasMovingBall) {
      float diff = millis() - this.idleStartTime;
      println("Time elaplsed since last event: "+diff);
      if (diff > IDLE_TIMEOUT * 1000) {
        this.startShooting();
        this.idleStartTime = 0;
      }
    }
  }

  void drawGUI() {
    if (this.idleStartTime > 0) {
      int diff = 10 - Math.round((millis() - this.idleStartTime) / 1000);
      hint(DISABLE_DEPTH_TEST);
      camera();
      textSize(26);
      text("Remaining time: "+diff+"s", 10, 30);
      hint(ENABLE_DEPTH_TEST);
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
      // Set position to exactly one radius away
      PVector tempPos, correctPos;
      b1.loseSpeed(2);
      b2.loseSpeed(2);

      // Calculate correct position by getting de difference of the two points and adding two radius to the correct way
      PVector dif = x2.copy().sub(x1);
      tempPos = x2.add(dif.copy().normalize().mult(-1*ar*2));
      correctPos = new PVector(tempPos.x, a.y, tempPos.y );
      b1.setPosition(correctPos);

      // Elastic collision
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

  public void startShooting() {
    float dist = cue.getCueDistance();
    float forcePercent = dist / cue.getMaxDistance();
    cueBall.setForce(BALL_FORCE * forcePercent);
    this.shootTime = millis();
    this.shooting = true;
  }

  public void shoot() {
    cueBall.shoot();
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
      this.startShooting();
    } else if (key == 'v') {
      cue.toggleVisibility();
    } 

    if (!this.hasMovingBall) {
      if (keyCode == RIGHT) {
        this.isRightPressed = true;
        this.idleStartTime = millis();
      } else if (keyCode == LEFT) {
        this.isLeftPressed = true;
        this.idleStartTime = millis();
      } else if (keyCode == UP) {
        this.isUpPressed = true;
        this.idleStartTime = millis();
      } else if (keyCode == DOWN) {
        this.isDownPressed = true;
        this.idleStartTime = millis();
      }
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

    if (keyCode == RIGHT) {
      this.isRightPressed = false;
    } else if (keyCode == LEFT) {
      this.isLeftPressed = false;
    } else if (keyCode == UP) {
      this.isUpPressed = false;
    } else if (keyCode == DOWN) {
      this.isDownPressed = false;
    }
  }

  public void mouseClicked() {
  }
}
