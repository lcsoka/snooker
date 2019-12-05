private PoolGame gameObject;

void setup() {
  size(720, 600);
  gameObject =  new  PoolGame();
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
