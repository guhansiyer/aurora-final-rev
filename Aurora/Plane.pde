//Template Plane Class
abstract class Plane {
  //Fields
  float xInitial;
  float yInitial;
  float xSize;
  float ySize;
  String title;

  //Constructor
  Plane(float xi, float yi, float xs, float ys, String t) {
    this.xInitial = xi;
    this.yInitial = yi;
    this.xSize = xs;
    this.ySize = ys;
    this.title = t;
  }

  //Draws a plane(although not used, it must be defined in the superclass).
  void drawPlane() {
    stroke(planeColour);
    fill(planeColour);
    rect(this.xInitial, this.yInitial, this.xSize, this.ySize);
  }
}
