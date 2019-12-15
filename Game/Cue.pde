public class Cue {
  private float cueLength = 500;
  private PVector position = new PVector(0, 0, 0); 
  private TruncatedCone body;
  private Cone topCircle, bottomCircle;
  private boolean visible = true;
  private Ball cueBall;
  private float distanceFromBall = 50;
  private float rotateX, rotateY, rotateZ = 0;
  private float cueDistance = 0;
  private float maxCueDistance = 50;

  Cue(PVector position, Ball cueBall) {
    this.position = position;
    this.cueBall = cueBall;
    this.initializeCue();
  }

  private void initializeCue() {
    this.body = new TruncatedCone(new PVector(0, 0, 0), 2, 5, cueLength);
    this.topCircle = new Cone(new PVector(0, 0, 0), 5);
    PVector bottomPos = new PVector(0, 0, 0).copy();
    bottomPos.add(new PVector(0, cueLength, 0));
    this.bottomCircle = new Cone(bottomPos, 2);
  }

  public void update() {
    this.position = this.cueBall.getPosition();

    PVector cueToBall = this.position.copy().sub(this.cueBall.getPosition());
    PVector ballDirection = this.cueBall.getDirection();
    //println(ballDirection);
    rotateX = (float)Math.acos(ballDirection.dot(new PVector(1, 0, 0))); 
    if (ballDirection.z < 0) {
      rotateX = -rotateX;
    }
    //rotateZ = (float)Math.acos(ballDirection.dot(new PVector(0, 0, 1)));

    //println((rotateX * 180 / PI)+", "+(rotateZ * 180 / PI));
  }

  public void setVisibility(boolean visible) {
    this.visible = visible;
  }

  public void toggleVisibility() {
    this.visible = !this.visible;
  }

  public void setDistance(float speed) {
   if(speed < 0) {
    this.cueDistance = Math.max(0,this.cueDistance += speed); 
   } else {
    this.cueDistance = Math.min(this.maxCueDistance,this.cueDistance += speed); 
   }
  }

  public float getCueDistance() {
    return this.cueDistance;
  }
  
  public float getMaxDistance() {
   return this.maxCueDistance; 
  }

  public void draw() {
    if (visible) {
      pushMatrix();
      //rotateX(PI );
      translate(position.x, position.y, position.z);

      //rotateX(PI / 2);

      //rotateZ(PI / 2);


      pushMatrix();
      // Vizszintesbe rakjuk
      rotateZ(-PI / 2);


      rotateX(rotateX);

      // Tetejet rakjuk a kozeppontba
      translate(0, -cueLength, 0);

      translate(0, -cueBall.getRadius() - this.getCueDistance(), 0);

      this.body.draw();
      this.topCircle.draw();
      this.bottomCircle.draw();
      popMatrix();
      popMatrix();
    }
  }
}
