//Subclass of Plane
class businessClassPlane extends Plane {
  businessClassPlane(float xi, float yi, float xs, float ys, String t) {
    super(xi, yi, xs, ys, t);
  }

  //Draws the economy class plane with different proportions and shapes than the other two subclasses.
  void drawPlane() {
    stroke(planeColour);
    fill(planeColour);
    rect(this.xInitial, this.yInitial, this.xSize, this.ySize);
  }
}
