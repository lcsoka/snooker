abstract class ParametricSurface {

  protected PVector position = new PVector(0, 0, 0);
  protected float detailness_u = 20;
  protected float detailness_v = 10;
  protected PVector shapeColor = new PVector(99, 69, 13);

  abstract PVector getPos(float u, float v);
  abstract PVector getNormal(float u, float v);

  void draw() {    
    pushMatrix();
    translate(position.x, position.y, position.z);
    beginShape(TRIANGLES);
    fill(shapeColor.x, shapeColor.y, shapeColor.z);
    float step_u = 1.0/detailness_u;
    float step_v = 1.0/detailness_v;

    for (int i = 0; i < detailness_u; ++i) {
      for (int j = 0; j < detailness_v; ++j) {
        float u = step_u * i;
        float v = step_v * j;

        PVector p1 = getPos(u, v);
        PVector p2 = getPos(u, v + step_v);
        PVector p3 = getPos(u+ step_u, v);
        PVector p4 = getPos(u+ step_u, v + step_v);

        PVector n1 = getNormal(u, v);
        PVector n2 = getNormal(u, v + step_v);
        PVector n3 = getNormal(u+ step_u, v);
        PVector n4 = getNormal(u+ step_u, v + step_v);

        normal(n3.x, n3.y, n3.z);
        vertex(p3.x, p3.y, p3.z, u + step_u, v);

        normal(n1.x, n1.y, n1.z);
        vertex(p1.x, p1.y, p1.z, u, v);    

        normal(n4.x, n4.y, n4.z);
        vertex(p4.x, p4.y, p4.z, u + step_u, v + step_v);

        normal(n1.x, n1.y, n1.z);
        vertex(p1.x, p1.y, p1.z, u, v);

        normal(n2.x, n2.y, n2.z);
        vertex(p2.x, p2.y, p2.z, u, v + step_v);

        normal(n4.x, n4.y, n4.z);
        vertex(p4.x, p4.y, p4.z, u + step_u, v + step_v);
      }
    }    
    endShape();
    popMatrix();
  }
}
