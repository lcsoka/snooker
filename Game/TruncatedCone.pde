class TruncatedCone extends ParametricSurface {
  private float r = 5;
  private float R = 15;
  private float h = 200;

  TruncatedCone(float r, float h) {
    this.r = r;
    this.h = h;
  }

  TruncatedCone(PVector position) {
    this.position = position;
  }


  TruncatedCone(PVector position, float r, float R, float h) {
    this.position = position;
    this.r = r;
    this.R = R;
    this.h = h;
    this. shapeColor = new PVector(247, 231, 165);
  }

  PVector getPos(float u, float v) {
    float alpha = u*2*PI;

    return new PVector(
      ((1-v)*R + v*r)*cos(alpha), 
      v*h, 
      ((1-v)*R + v*r)*sin(alpha)      
      );
  }

  PVector getNormal(float u, float v) {
    float alpha = u*2*PI;

    return new PVector(
      cos(alpha), 
      (R-r)/h, 
      sin(alpha)     
      );
  }
}
