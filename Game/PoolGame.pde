import peasy.*;
int planeSize = 500;
public class PoolGame {
  Camera camera;
  PeasyCam cam;
  PoolTable table;
  Ball ball;
  
  PoolGame(Game g) {
    cam = new PeasyCam(g, 1000);
    table = new PoolTable();
    ball = new Ball(new PVector(0,-20,0));
  }

  public void draw() {
    background(158, 228, 255);
    update();

    table.draw();
    ball.draw();
  }

  void update() {
    //camera.update();
    table.update();
    ball.update();
  }

  public void keyPressed() {
  }

  public void mouseClicked() {
  }
}
