public class Border {

  private PVector A;
  private PVector B;
  private PVector C;
  private PVector D;
  private PVector E;
  private PVector F;
  private PVector G;
  private PVector H;
  private int w = 50;

  Border(PVector A, PVector B, PVector C, PVector D) {
    this.A = A;
    this.B = B;
    this.C = C;
    this.D = D;
    E = A.copy().add(new PVector(0, -w/2, 0));
    F = B.copy().add(new PVector(0, -w/2, 0));
    G = C.copy().add(new PVector(0, -w/2, 0));
    H = D.copy().add(new PVector(0, -w/2, 0));
  }

  void draw() {
    fill(99, 69, 13);

    beginShape(QUADS);
    // Bottom
    vertex(A.x, A.y, A.z);
    vertex(B.x, B.y, B.z);
    vertex(C.x, C.y, C.z);
    vertex(D.x, D.y, D.z);
    // Top
    vertex(E.x, E.y, E.z);
    vertex(F.x, F.y, F.z);
    vertex(G.x, G.y, G.z);
    vertex(H.x, H.y, H.z);

    // Left
    vertex(A.x, A.y, A.z);
    vertex(E.x, E.y, E.z);
    vertex(H.x, H.y, H.z);
    vertex(D.x, D.y, D.z);

    // Right
    vertex(B.x, B.y, B.z);
    vertex(F.x, F.y, F.z);
    vertex(G.x, G.y, G.z);
    vertex(C.x, C.y, C.z);

    // Front
    vertex(D.x, D.y, D.z);
    vertex(H.x, H.y, H.z);
    vertex(G.x, G.y, G.z);
    vertex(C.x, C.y, C.z);

    // Back
    vertex(A.x, A.y, A.z);
    vertex(E.x, E.y, E.z);
    vertex(F.x, F.y, F.z);
    vertex(B.x, B.y, B.z);

    endShape(CLOSE);
  }
}
