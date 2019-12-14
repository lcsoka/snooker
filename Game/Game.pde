private PoolGame gameObject;
public static boolean DEBUG = false;
public static float BALL_RADIUS = 10;
void setup() {
  size(800, 600, P3D);
  gameObject = new PoolGame(this);
}

void draw() {
  gameObject.draw();
}

void keyPressed() {
  gameObject.keyPressed();
}

void keyReleased() {
  gameObject.keyReleased();
}

void mouseClicked() {
  gameObject.mouseClicked();
}
