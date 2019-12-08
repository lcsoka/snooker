public class Camera {
  PVector eye = new PVector(-10, 0, -10);
  PVector up = new PVector(0, 1, 0);
  PVector at = new PVector(0, 0, 0);

  PVector lastMousePos = null;
  float lastTime;
  float speed = 10;
  float alpha = 0;
  float beta = PI/2;

  Camera() {
    update(); 
    lastTime = millis();
  }

  PVector getForward() {
    PVector fw = (at.copy().sub(eye));
    fw.normalize();
    return fw;
  }

  PVector getRight() {
    PVector fw = getForward();
    PVector right = fw.copy().cross(up);
    right.normalize();
    return right;
  }

  void update() {
    float deltaTime = (millis() - lastTime)/1000.0;
    lastTime = millis();

    PVector fw = getForward();
    fw.mult(deltaTime*speed);

    // ...


    if (mousePressed) {
      if (lastMousePos == null) {
        lastMousePos = new PVector(mouseX, mouseY);
      } else {
        float dx = (mouseX - lastMousePos.x)/100.0;
        float dy = (mouseY - lastMousePos.y)/100.0;

        alpha += dx;
        beta -= dy;

        if (beta < 0.1) {
          beta = 0.1;
        } else if (beta > 3.1) {
          beta = 3.1;
        }

        lastMousePos = new PVector(mouseX, mouseY);
      }
    } else {
      lastMousePos = null;
    }

    PVector spherePos = new PVector(
      sin(beta)*cos(alpha), 
      cos(beta), 
      sin(beta)*sin(alpha));

    at = eye.copy().add(spherePos);
    applyCamera();
  }

  void applyCamera() {
    perspective(PI/3, width/(float)height, 0.01, 1000);
    camera(eye.x, eye.y, eye.z, 
      at.x, at.y, at.z, 
      up.x, up.y, up.z);
  }
}
