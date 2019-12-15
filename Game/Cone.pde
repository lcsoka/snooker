class Cone extends ParametricSurface {
  private float r = 5;
  
  
  private float h = 0;

  Cone(float r) {
    this.r = r;
  }

  Cone(PVector position) {
    this.position = position;
  }


  Cone(PVector position, float r) {
    this.position = position;
    this.r = r;
  }

  PVector getPos(float u, float v) {
    float alpha = u*2*PI;
    
    return new PVector(
      r*(1-v)*cos(alpha), 
      v*h, 
      r*(1-v)*sin(alpha)      
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
