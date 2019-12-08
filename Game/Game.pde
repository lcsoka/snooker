private PoolGame gameObject;
public static boolean DEBUG = true;
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

void mouseClicked() {
  gameObject.mouseClicked();
}
