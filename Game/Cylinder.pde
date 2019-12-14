class Cylinder extends ParametricSurface {
  private float r = 25;
  private float h = 200;

  Cylinder(float r, float h) {
    this.r = r;
    this.h = h;
  }

  Cylinder(PVector position) {
    this.position = position;
  }


  Cylinder(PVector position, float r, float h) {
    this.position = position;
    this.r = r;
    this.h = h;
  }

  PVector getPos(float u, float v) {
    float alpha = u*2*PI;

    return new PVector(
      r*cos(alpha), 
      v*h, 
      r*sin(alpha)     
      );
  }

  PVector getNormal(float u, float v) {
    float alpha = u*2*PI;

    return new PVector(
      cos(alpha), 
      0, 
      sin(alpha)     
      );
  }
}
